# Mud Soccer Player - AI 개발 가이드

## 프로젝트 개요

텍스트 기반 축구 커리어 MUD 게임. 플레이어가 축구 선수가 되어 훈련하고, 경기에 참여하며, 커리어를 쌓아가는 시뮬레이션 게임.

## 기술 스택

- **Framework**: Flutter (Dart SDK ^3.10.7)
- **상태관리**: Riverpod (flutter_riverpod)
- **라우팅**: GoRouter
- **데이터 모델**: Freezed (불변 객체)
- **저장**: Hive (로컬 스토리지)

## 아키텍처

### Single Source of Truth (SSOT)

```
GameState (유일한 상태 원천)
├── PlayerState (플레이어 캐릭터, 주간 행동)
├── SeasonState (시즌, 팀, 경기 일정, 순위표)
├── UIScreenState (현재 화면, 진행 중인 경기)
└── MetaState (버전, 저장 시간)
```

### Pure Function Engine 패턴

모든 게임 로직은 순수 함수 엔진으로 처리:
```dart
(State, Action, Seed) → State'
```

- **입력**: 현재 상태 + 액션 + 난수 시드
- **출력**: 새로운 상태 (부작용 없음)
- **장점**: 테스트 용이, 결정론적 결과, 리플레이 가능

### 주요 컴포넌트

| 컴포넌트 | 위치 | 역할 |
|---------|------|------|
| `GameOrchestrator` | `lib/application/orchestrator.dart` | 액션 디스패치, 엔진 라우팅, 복합 액션 처리 |
| `GameStateStore` | `lib/application/orchestrator.dart` | 상태 저장소 (ChangeNotifier) |
| `TrainingEngine` | `lib/domain/engine/training_engine.dart` | 훈련 로직 |
| `MatchEngine` | `lib/domain/engine/match_engine.dart` | 경기 로직 |
| `LeagueEngineV2` | `lib/domain/engine/league_engine_v2.dart` | 리그/순위 로직 |
| `CareerEngine` | `lib/domain/engine/career_engine.dart` | 커리어 통계 |

## 디렉토리 구조

```
lib/
├── app/                    # 앱 설정, 라우팅
│   ├── app.dart
│   └── routes.dart
├── application/            # 비즈니스 로직
│   ├── orchestrator.dart   # 게임 오케스트레이터
│   └── providers.dart      # Riverpod 프로바이더
├── data/                   # 데이터 레이어
│   └── storage/
│       └── hive_store.dart
├── domain/                 # 도메인 레이어
│   ├── action/             # 액션 정의
│   │   └── game_action.dart
│   ├── config/             # 밸런스 설정
│   │   └── balance_config.dart
│   ├── engine/             # 순수 함수 엔진들
│   │   ├── base_engine.dart
│   │   ├── training_engine.dart
│   │   ├── match_engine.dart
│   │   ├── league_engine_v2.dart
│   │   └── ...
│   ├── model/              # 데이터 모델 (Freezed)
│   │   ├── player.dart
│   │   ├── team.dart
│   │   ├── match.dart
│   │   └── ...
│   ├── state/              # 게임 상태
│   │   └── game_state.dart
│   └── text/               # 텍스트/해설
│       └── commentary.dart
└── presentation/           # UI 레이어
    ├── home/
    ├── training/
    ├── match/
    └── ...
```

## 코딩 컨벤션

### 상태 변경

상태는 반드시 `GameOrchestrator.dispatch()`를 통해서만 변경:

```dart
// Good
orchestrator.dispatch(ExecuteTraining(TrainingType.shooting));

// Bad - 직접 상태 변경 금지
state = state.copyWith(...);
```

### 액션 정의

`lib/domain/action/game_action.dart`에 sealed class로 정의:

```dart
sealed class TrainingAction extends GameAction {}

class ExecuteTraining extends TrainingAction {
  final TrainingType type;
  ExecuteTraining(this.type);
}
```

### 엔진 구현

`GameEngine<T>`를 상속하여 구현:

```dart
class TrainingEngine extends GameEngine<TrainingAction> {
  @override
  bool canHandle(GameAction action) => action is TrainingAction;

  @override
  GameState process(GameState state, TrainingAction action, int seed) {
    // 순수 함수로 새 상태 반환
  }
}
```

### 밸런스 값

하드코딩 대신 `lib/domain/config/balance_config.dart` 사용:

```dart
// Good
fatigue: (newStatus.fatigue + TrainingConfig.fatigueDefault).clamp(0, 100)

// Bad
fatigue: (newStatus.fatigue + 15).clamp(0, 100)
```

## 테스트

```bash
# 전체 테스트 실행
flutter test

# 특정 테스트 실행
flutter test test/domain/engine_test.dart
```

## 코드 생성

Freezed 모델 변경 후:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 주요 화면

| 경로 | 화면 | 설명 |
|------|------|------|
| `/` | 로비 | 새 게임/불러오기 선택 |
| `/home` | 홈 | 대시보드, 선수 정보, 다음 경기 |
| `/training` | 훈련 | 훈련 타입 선택 |
| `/match` | 경기 | 하이라이트 기반 경기 진행 |
| `/summary` | 요약 | 경기 결과 |
| `/career` | 커리어 | 선수 상세 정보 |
| `/standings` | 순위표 | 팀/개인 순위 |
| `/fixtures` | 일정 | 리그 일정 및 결과 |

## 주의사항

1. **불변성 유지**: 모든 상태 객체는 Freezed로 불변. `copyWith` 사용.
2. **순수 함수**: 엔진은 부작용 없이 순수 함수로 작성.
3. **단일 진실 원천**: `GameState`가 유일한 상태 원천. 파생 상태 금지.
4. **한국어 UI**: 모든 사용자 인터페이스 텍스트는 한국어.
5. **밸런스 수정**: 게임 밸런스 수치는 `balance_config.dart`에서 관리.
