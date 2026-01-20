# 게임 엔진 아키텍처 구현 계획

## 목표
ADR-000에 정의된 아키텍처를 구현하여:
- Single Source of Truth 확립
- 관심분리 (데이터/렌더링/시뮬레이션/업데이트)
- 순수 함수 기반 엔진

## 현재 상태 분석

### 문제점
1. `GameController` 710줄+ - 모든 로직이 한 곳에
2. AI 경기 시뮬레이션 로직 중복 (finishMatch, spectateMatch)
3. 중간 상태 변수 재할당 패턴
4. 테스트 어려움

### 강점 (유지할 것)
- Freezed 기반 불변 모델
- copyWith 패턴 일관성
- Riverpod Provider 구조

---

## 구현 계획

### Phase 1: 기반 구조 생성

#### Step 1.1: 디렉토리 구조 생성
```
lib/
├── domain/
│   ├── state/           # 새로 생성
│   │   ├── game_state.dart
│   │   ├── player_state.dart
│   │   ├── season_state.dart
│   │   └── ui_state.dart
│   │
│   ├── action/          # 새로 생성
│   │   ├── game_action.dart
│   │   ├── training_action.dart
│   │   ├── match_action.dart
│   │   └── league_action.dart
│   │
│   └── engine/          # 기존 확장
│       ├── base_engine.dart     # 새로 생성
│       ├── training_engine.dart # 새로 생성
│       ├── match_engine.dart    # 새로 생성
│       └── league_engine.dart   # 새로 생성
│
├── application/
│   ├── orchestrator.dart  # 새로 생성
│   ├── store.dart         # 새로 생성
│   └── providers.dart     # 수정
```

#### Step 1.2: 기존 모델과의 호환성
현재 `GameSnapshot`을 새 `GameState`로 점진적 마이그레이션:
- 기존 코드가 깨지지 않도록 어댑터 패턴 사용
- 새 State와 기존 Snapshot 간 변환 레이어

---

### Phase 2: State 모델 정의

#### Step 2.1: GameState (새 Single Source of Truth)
```dart
@freezed
class GameState with _$GameState {
  const factory GameState({
    required PlayerState player,
    required SeasonState season,
    required UIState ui,
    required MetaState meta,
  }) = _GameState;

  /// 기존 GameSnapshot에서 변환
  factory GameState.fromSnapshot(GameSnapshot snapshot);

  /// 기존 GameSnapshot으로 변환 (저장용)
  GameSnapshot toSnapshot();
}
```

#### Step 2.2: 서브 State들
- `PlayerState`: PC 정보 (기존 PlayerCharacter 기반)
- `SeasonState`: 리그, 순위표, 일정 (기존 Season 기반)
- `UIState`: 현재 화면, 활성 경기 등
- `MetaState`: 버전, 저장 시간

---

### Phase 3: Action 정의

#### Step 3.1: 기본 Action sealed class
```dart
sealed class GameAction {
  const GameAction();
}
```

#### Step 3.2: 도메인별 Action
- `TrainingAction`: 훈련 유형
- `MatchAction`: 경기 시작/선택/다음/종료
- `LeagueAction`: 순위 업데이트/라운드 진행
- `CareerAction`: XP/신뢰도/평판 업데이트

---

### Phase 4: Engine 분리

#### Step 4.1: BaseEngine 추상 클래스
```dart
abstract class GameEngine<A extends GameAction> {
  bool canHandle(GameAction action);
  GameState process(GameState state, A action, int seed);
}
```

#### Step 4.2: TrainingEngine (가장 단순, 먼저 구현)
- 기존 `applyTraining()` 로직 추출
- 순수 함수로 변환
- 테스트 작성

#### Step 4.3: LeagueEngine
- 순위표 업데이트 로직 추출
- AI 경기 시뮬레이션 로직 통합 (중복 제거)
- 라운드 진행 로직

#### Step 4.4: MatchEngine
- 기존 HighlightGenerator, Resolver 활용
- 경기 진행 상태 머신
- 하이라이트 선택 처리

#### Step 4.5: CareerEngine
- XP/레벨업 로직
- 신뢰도/평판 업데이트
- 경기 기록 저장

---

### Phase 5: Orchestrator 구현

#### Step 5.1: GameOrchestrator
```dart
class GameOrchestrator {
  final List<GameEngine> _engines;
  final GameStateStore _store;

  void dispatch(GameAction action) {
    // 1. 적절한 엔진 선택
    // 2. 새 상태 계산
    // 3. 후속 처리
    // 4. 상태 업데이트
  }
}
```

#### Step 5.2: 복합 액션 처리
- `finishMatch()` 같은 복합 작업을 여러 dispatch로 분해
- 트랜잭션처럼 원자적 처리

---

### Phase 6: 마이그레이션

#### Step 6.1: Provider 업데이트
```dart
// 기존
final gameControllerProvider = StateNotifierProvider<GameController, GameSnapshot?>;

// 신규
final gameStateStoreProvider = Provider<GameStateStore>;
final orchestratorProvider = Provider<GameOrchestrator>;
final gameStateProvider = StateProvider<GameState>;
```

#### Step 6.2: UI 마이그레이션
- 기존 `ref.read(gameControllerProvider.notifier).method()`
- 신규 `ref.read(orchestratorProvider).dispatch(Action(...))`

#### Step 6.3: GameController 점진적 제거
1. 새 Orchestrator와 병행 운영
2. 메서드별로 하나씩 마이그레이션
3. 모든 메서드 마이그레이션 후 삭제

---

## 구현 순서 (권장)

```
1. State 모델 정의 (1-2시간)
   └── GameState, PlayerState, SeasonState, UIState

2. Action 정의 (1시간)
   └── TrainingAction, MatchAction, LeagueAction

3. TrainingEngine 구현 (1-2시간)
   └── 가장 단순, 패턴 확립

4. LeagueEngine 구현 (2시간)
   └── 중복 로직 통합

5. MatchEngine 구현 (3-4시간)
   └── 가장 복잡

6. Orchestrator 구현 (2시간)
   └── 엔진 조합

7. 마이그레이션 (2-3시간)
   └── Provider 교체, UI 업데이트

8. 테스트 (1-2시간)
   └── 각 엔진 단위 테스트
```

---

## 리스크 및 대응

| 리스크 | 대응 |
|--------|------|
| 기존 기능 깨짐 | 점진적 마이그레이션, 병행 운영 |
| State 변환 오류 | fromSnapshot/toSnapshot 철저 테스트 |
| 성능 저하 | 필요시 memoization 적용 |
| 복잡도 증가 | 문서화, 명확한 책임 분리 |

---

## 완료 조건

- [ ] 모든 상태 변경이 Action을 통해 발생
- [ ] GameController 제거됨
- [ ] 각 엔진이 독립적으로 테스트 가능
- [ ] AI 경기 시뮬레이션 로직 통합 (중복 제거)
- [ ] 기존 기능 100% 동작
