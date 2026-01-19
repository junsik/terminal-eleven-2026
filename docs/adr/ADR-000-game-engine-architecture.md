# ADR-000: 게임 엔진 아키텍처

## 상태
제안됨

## 컨텍스트

### 현재 문제점

현재 `GameController`가 710줄 이상의 거대한 클래스로, 모든 로직을 담당합니다:
- 훈련 처리
- 경기 진행
- 스코어 계산
- 순위표 업데이트
- 부상 처리
- 저장/로드
- UI 상태 전환

**위반 사항:**
1. **관심분리 위반**: 하나의 클래스가 모든 책임을 가짐
2. **Single Source of Truth 위반**: 상태가 여러 곳에서 직접 수정됨
3. **테스트 어려움**: 개별 로직을 분리 테스트 불가
4. **확장 어려움**: 새 기능(이적, 이벤트 등) 추가 시 더 비대해짐

### 요구사항

- **관심분리 (Separation of Concerns)**: 각 도메인이 자신의 역할만 담당
- **Single Source of Truth**: 모든 상태는 하나의 원천에서 관리
- **순수 함수 기반**: 부작용 없이 예측 가능한 상태 변경
- **테스트 용이성**: 각 엔진을 독립적으로 테스트 가능
- **확장성**: 새 기능 추가 시 기존 코드 영향 최소화

## 결정

### 1. 아키텍처 개요

```
┌─────────────────────────────────────────────────────────────────┐
│                        GameState (Single Source of Truth)       │
│                        ═══════════════════════════════════      │
│  모든 게임 데이터의 유일한 원천. 불변(Immutable) 객체.          │
└───────────────────────────────┬─────────────────────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │     GameOrchestrator   │
                    │     ════════════════   │
                    │  이벤트 수신 & 라우팅  │
                    │  엔진 조합 & 실행      │
                    │  상태 업데이트 발행    │
                    └───────────┬───────────┘
                                │
        ┌───────────┬───────────┼───────────┬───────────┐
        │           │           │           │           │
        ▼           ▼           ▼           ▼           ▼
┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐
│ Training  │ │  Match    │ │  League   │ │  Career   │ │  Event    │
│  Engine   │ │  Engine   │ │  Engine   │ │  Engine   │ │  Engine   │
├───────────┤ ├───────────┤ ├───────────┤ ├───────────┤ ├───────────┤
│ 훈련 처리 │ │ 경기 진행 │ │ 순위/일정 │ │ 성장/이적 │ │ 스토리    │
│ 스탯 변경 │ │ 하이라이트│ │ AI 시뮬   │ │ 레벨업    │ │ 랜덤이벤트│
│ 피로/부상 │ │ 확률 계산 │ │ 시즌 진행 │ │ 평판/신뢰 │ │ 플래그    │
└───────────┘ └───────────┘ └───────────┘ └───────────┘ └───────────┘
     │             │             │             │             │
     └─────────────┴─────────────┴─────────────┴─────────────┘
                                │
                    ┌───────────▼───────────┐
                    │    Pure Functions     │
                    │    ══════════════     │
                    │  (State) → (State')   │
                    │  입력 → 출력 (부작용X)│
                    └───────────────────────┘
```

### 2. 핵심 원칙

#### 2.1 Single Source of Truth

```dart
/// 게임의 모든 상태를 담는 불변 객체
/// 이 객체가 유일한 진실의 원천
@freezed
class GameState with _$GameState {
  const factory GameState({
    required PlayerState player,
    required SeasonState season,
    required LeagueState league,
    required EventState events,
    required TransferState transfer,
    required UIState ui,
    required MetaState meta,  // 저장 시간, 버전 등
  }) = _GameState;
}
```

**규칙:**
- 모든 데이터는 `GameState` 안에만 존재
- 외부에서 직접 수정 불가 (불변)
- 상태 변경은 오직 **Action → Reducer** 패턴으로만

#### 2.2 데이터 원천과 소비자 분리

**핵심 원칙:** 데이터는 한 곳에만 존재하고, 여러 소비자가 이를 읽기만 한다.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DATA (Single Source of Truth)                    │
│                    ═════════════════════════════                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐  │
│  │  TeamData   │  │ PlayerData  │  │ LeagueData  │  │ EventData │  │
│  │  ─────────  │  │  ─────────  │  │  ─────────  │  │ ───────── │  │
│  │  - 팀 목록  │  │  - PC 스탯  │  │  - 순위표   │  │ - 플래그  │  │
│  │  - 팀 스탯  │  │  - PC 상태  │  │  - 일정     │  │ - 이벤트  │  │
│  │  - 로스터  │  │  - 커리어   │  │  - 결과     │  │ - 선택지  │  │
│  └─────────────┘  └─────────────┘  └─────────────┘  └───────────┘  │
│                                                                     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
           ┌─────────────────┼─────────────────┐
           │                 │                 │
           ▼                 ▼                 ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│   RENDERER      │ │   SIMULATOR     │ │   VALIDATOR     │
│   (읽기 전용)   │ │   (계산 전용)   │ │   (검증 전용)   │
├─────────────────┤ ├─────────────────┤ ├─────────────────┤
│                 │ │                 │ │                 │
│ • 홈 화면       │ │ • AI 경기 시뮬 │ │ • 훈련 가능?    │
│ • 순위표 렌더   │ │ • 이적 관심도  │ │ • 경기 출전?    │
│ • 경기 로그     │ │ • 스탯 계산    │ │ • 이적 조건?    │
│ • 선수 정보    │ │ • 확률 계산    │ │ • 이벤트 조건?  │
│                 │ │                 │ │                 │
│ 데이터 → UI    │ │ 데이터 → 결과  │ │ 데이터 → bool   │
│                 │ │                 │ │                 │
└─────────────────┘ └─────────────────┘ └─────────────────┘
         │                   │                   │
         └───────────────────┼───────────────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │    UPDATER      │
                    │   (쓰기 전용)   │
                    ├─────────────────┤
                    │                 │
                    │ • 훈련 결과     │
                    │ • 경기 결과     │
                    │ • 순위 업데이트 │
                    │ • 이벤트 처리   │
                    │                 │
                    │ 새 State 반환   │
                    └─────────────────┘
```

**데이터 접근 규칙:**

```dart
/// ❌ 나쁜 예: 여러 곳에서 데이터 보유
class HomeScreen {
  List<Team> teams;  // 복사본 보유 ❌
}

class LeagueSimulator {
  List<Team> teams;  // 또 다른 복사본 ❌
}

/// ✅ 좋은 예: 데이터는 한 곳, 접근만 분리
class GameState {
  final LeagueState league;  // 유일한 원천
}

// 렌더러: 읽기만
class HomeScreen extends ConsumerWidget {
  Widget build(context, ref) {
    final teams = ref.watch(gameStateProvider.select((s) => s.league.teams));
    return TeamList(teams: teams);  // 읽기 전용
  }
}

// 시뮬레이터: 계산만 (상태 변경 X)
class LeagueSimulator {
  MatchResult simulate(Team home, Team away, int seed) {
    // 입력받은 데이터로 계산만 수행
    // 원본 데이터 수정 안 함
    return MatchResult(...);
  }
}

// 업데이터: 새 상태 반환
class LeagueEngine {
  GameState applyResult(GameState state, MatchResult result) {
    // 새로운 불변 상태 반환
    return state.copyWith(
      league: state.league.copyWith(
        standings: _updateStandings(state.league.standings, result),
      ),
    );
  }
}
```

**예시: 순위표 업데이트 흐름**

```
1. [데이터 원천] GameState.league.standings
                    │
2. [시뮬레이터]     │
   LeagueSimulator.simulate(homeTeam, awayTeam)
   → MatchResult(homeScore: 2, awayScore: 1)
                    │
3. [업데이터]       │
   LeagueEngine.applyResult(state, matchResult)
   → 새로운 GameState (standings 업데이트됨)
                    │
4. [데이터 원천]    │
   Store.update(newState)  ← 유일한 쓰기 지점
                    │
5. [렌더러]         │
   StandingsScreen.build()
   → ref.watch(gameStateProvider.select((s) => s.league.standings))
   → UI 자동 리빌드
```

**팀/선수/리그 데이터 구조:**

```dart
@freezed
class LeagueState with _$LeagueState {
  const factory LeagueState({
    /// 팀 데이터 (유일한 원천)
    required Map<String, Team> teams,

    /// 순위표 (teams를 참조하는 TeamId만 보유)
    required List<StandingRow> standings,

    /// 일정 (teams를 참조하는 TeamId만 보유)
    required List<Fixture> fixtures,

    /// 현재 라운드
    required int currentRound,

    /// AI 선수 데이터 (시뮬레이션용)
    required Map<String, AIPlayerStats> aiPlayers,
  }) = _LeagueState;
}

@freezed
class StandingRow with _$StandingRow {
  const factory StandingRow({
    required String teamId,  // Team 객체가 아닌 ID만 참조!
    required int played,
    required int won,
    required int drawn,
    required int lost,
    required int goalsFor,
    required int goalsAgainst,
  }) = _StandingRow;

  /// 팀 정보가 필요하면 state에서 조회
  Team getTeam(LeagueState state) => state.teams[teamId]!;
}
```

#### 2.3 Action-Based State Update

```dart
/// 모든 상태 변경은 Action으로 표현
sealed class GameAction {
  const GameAction();
}

// 훈련 액션
class TrainingAction extends GameAction {
  final TrainingType type;
  const TrainingAction(this.type);
}

// 경기 액션
class MatchAction extends GameAction {
  final MatchActionType type;
  final CommandType? command;
  const MatchAction(this.type, [this.command]);
}

// 이벤트 선택 액션
class EventChoiceAction extends GameAction {
  final String eventId;
  final int choiceIndex;
  const EventChoiceAction(this.eventId, this.choiceIndex);
}

// 이적 액션
class TransferAction extends GameAction {
  final TransferActionType type;
  final String? offerId;
  const TransferAction(this.type, [this.offerId]);
}
```

#### 2.3 순수 함수 기반 엔진

```dart
/// 모든 엔진은 순수 함수로 구현
/// (현재 상태, 액션, 랜덤시드) → 새로운 상태
abstract class GameEngine<A extends GameAction> {
  /// 이 엔진이 처리할 수 있는 액션인지 확인
  bool canHandle(GameAction action);

  /// 액션을 처리하고 새로운 상태 반환
  /// 부작용 없음 (Pure Function)
  GameState process(GameState state, A action, int seed);
}
```

### 3. 엔진 분리

#### 3.1 TrainingEngine

```dart
/// 훈련만 담당
class TrainingEngine extends GameEngine<TrainingAction> {
  @override
  bool canHandle(GameAction action) => action is TrainingAction;

  @override
  GameState process(GameState state, TrainingAction action, int seed) {
    final random = Random(seed);
    final training = action.type;

    // 1. 스탯 변경 계산
    final statDelta = _calculateStatDelta(training, random);

    // 2. 피로 변경 계산
    final fatigueDelta = _calculateFatigueDelta(training);

    // 3. 부상 체크
    final injuryResult = _checkInjury(state.player.status, training, random);

    // 4. 새 상태 반환 (불변 업데이트)
    return state.copyWith(
      player: state.player.copyWith(
        stats: state.player.stats.apply(statDelta),
        status: state.player.status.copyWith(
          fatigue: (state.player.status.fatigue + fatigueDelta).clamp(0, 100),
          injury: injuryResult.injury,
          injuryWeeks: injuryResult.weeks,
        ),
      ),
      season: state.season.copyWith(
        weeklyActionsRemaining: state.season.weeklyActionsRemaining - 1,
      ),
    );
  }

  StatDelta _calculateStatDelta(TrainingType type, Random random) {
    // 순수 함수: 같은 입력이면 같은 출력
    return switch (type) {
      TrainingType.shooting => StatDelta(shooting: 1 + random.nextInt(2)),
      TrainingType.passing => StatDelta(passing: 1 + random.nextInt(2)),
      // ...
    };
  }
}
```

#### 3.2 MatchEngine

```dart
/// 경기 진행만 담당
class MatchEngine extends GameEngine<MatchAction> {
  final HighlightGenerator _highlightGen;
  final HighlightResolver _resolver;
  final CommentaryGenerator _commentary;

  @override
  GameState process(GameState state, MatchAction action, int seed) {
    return switch (action.type) {
      MatchActionType.start => _startMatch(state, seed),
      MatchActionType.proceed => _proceedFromIntro(state),
      MatchActionType.choice => _processChoice(state, action.command!, seed),
      MatchActionType.next => _nextHighlight(state),
      MatchActionType.finish => _finishMatch(state),
    };
  }

  GameState _processChoice(GameState state, CommandType command, int seed) {
    final match = state.ui.activeMatch!;
    final highlight = match.currentHighlight!;

    // 1. 결과 계산 (순수 함수)
    final result = _resolver.resolve(
      event: highlight,
      command: command,
      stats: state.player.stats,
      status: state.player.status,
      opponentRating: _getOpponentRating(state),
      seed: seed,
    );

    // 2. 새 상태 계산 (순수 함수)
    return state.copyWith(
      player: _applyResultToPlayer(state.player, result),
      ui: state.ui.copyWith(
        activeMatch: _applyResultToMatch(match, result, command),
      ),
    );
  }
}
```

#### 3.3 LeagueEngine

```dart
/// 리그/순위표만 담당
class LeagueEngine extends GameEngine<LeagueAction> {
  @override
  GameState process(GameState state, LeagueAction action, int seed) {
    return switch (action.type) {
      LeagueActionType.updateStandings => _updateStandings(state, action.matchResult!),
      LeagueActionType.simulateAIMatches => _simulateAIMatches(state, seed),
      LeagueActionType.advanceRound => _advanceRound(state),
      LeagueActionType.endSeason => _endSeason(state),
    };
  }

  GameState _updateStandings(GameState state, MatchResult result) {
    // 순수 함수: standings 업데이트
    final newStandings = state.league.standings.map((row) {
      if (row.teamId == result.homeTeamId) {
        return _applyHomeResult(row, result);
      } else if (row.teamId == result.awayTeamId) {
        return _applyAwayResult(row, result);
      }
      return row;
    }).toList();

    return state.copyWith(
      league: state.league.copyWith(standings: newStandings),
    );
  }
}
```

#### 3.4 CareerEngine

```dart
/// 선수 성장/커리어만 담당
class CareerEngine extends GameEngine<CareerAction> {
  @override
  GameState process(GameState state, CareerAction action, int seed) {
    return switch (action.type) {
      CareerActionType.addXP => _addXP(state, action.amount!),
      CareerActionType.updateTrust => _updateTrust(state, action.delta!),
      CareerActionType.updateReputation => _updateReputation(state, action.delta!),
      CareerActionType.levelUp => _levelUp(state),
      CareerActionType.recordMatch => _recordMatchStats(state, action.matchStats!),
    };
  }
}
```

#### 3.5 EventEngine

```dart
/// 스토리 이벤트만 담당
class EventEngine extends GameEngine<EventAction> {
  final List<StoryEvent> _allEvents;

  @override
  GameState process(GameState state, EventAction action, int seed) {
    return switch (action.type) {
      EventActionType.check => _checkTriggers(state, seed),
      EventActionType.choice => _applyChoice(state, action.eventId!, action.choiceIndex!),
      EventActionType.dismiss => _dismissEvent(state, action.eventId!),
    };
  }

  GameState _checkTriggers(GameState state, int seed) {
    final random = Random(seed);
    final triggered = <StoryEvent>[];

    for (final event in _allEvents) {
      if (_shouldTrigger(event, state, random)) {
        triggered.add(event);
      }
    }

    if (triggered.isEmpty) return state;

    // 우선순위 정렬 후 최대 1개 활성화
    final selected = _prioritize(triggered).first;

    return state.copyWith(
      events: state.events.copyWith(
        activeEvent: selected,
        completedEvents: [...state.events.completedEvents],
      ),
    );
  }
}
```

#### 3.6 TransferEngine

```dart
/// 이적만 담당
class TransferEngine extends GameEngine<TransferAction> {
  @override
  GameState process(GameState state, TransferAction action, int seed) {
    return switch (action.type) {
      TransferActionType.checkInterest => _checkInterest(state, seed),
      TransferActionType.receiveOffer => _receiveOffer(state, action.offer!),
      TransferActionType.accept => _acceptOffer(state, action.offerId!),
      TransferActionType.reject => _rejectOffer(state, action.offerId!),
      TransferActionType.negotiate => _negotiate(state, action.offerId!, seed),
    };
  }
}
```

### 4. GameOrchestrator (조합기)

```dart
/// 엔진들을 조합하고 상태를 관리하는 오케스트레이터
class GameOrchestrator {
  final List<GameEngine> _engines;
  final GameStateStore _store;  // Single Source of Truth
  final Random _seedGenerator;

  GameOrchestrator({
    required List<GameEngine> engines,
    required GameStateStore store,
  }) : _engines = engines,
       _store = store,
       _seedGenerator = Random();

  /// 액션을 디스패치하고 상태 업데이트
  void dispatch(GameAction action) {
    final currentState = _store.state;
    final seed = _seedGenerator.nextInt(1 << 32);

    // 1. 적절한 엔진 찾기
    final engine = _engines.firstWhere(
      (e) => e.canHandle(action),
      orElse: () => throw UnhandledActionError(action),
    );

    // 2. 새 상태 계산 (순수 함수)
    var newState = engine.process(currentState, action, seed);

    // 3. 후속 액션 체크 (이벤트 트리거 등)
    newState = _checkSideEffects(newState, seed);

    // 4. 상태 업데이트 (Single Source of Truth)
    _store.update(newState);
  }

  GameState _checkSideEffects(GameState state, int seed) {
    // 경기 종료 후 → 이벤트 체크
    // 훈련 후 → 이벤트 체크
    // 시즌 종료 → 이적 시장 진입
    // 등등...

    final eventEngine = _engines.whereType<EventEngine>().first;
    return eventEngine.process(state, const EventAction.check(), seed);
  }
}
```

### 5. GameStateStore (상태 저장소)

```dart
/// Single Source of Truth 구현
class GameStateStore extends ChangeNotifier {
  GameState _state;

  GameState get state => _state;

  GameStateStore(GameState initialState) : _state = initialState;

  /// 상태 업데이트 (유일한 변경 지점)
  void update(GameState newState) {
    if (_state == newState) return;  // 변경 없으면 무시

    _state = newState;
    notifyListeners();

    // 자동 저장
    _autoSave(newState);
  }

  Future<void> _autoSave(GameState state) async {
    await gameStorage.saveSnapshot(state.toSnapshot());
  }
}
```

### 6. 복합 액션 처리

경기 종료처럼 여러 엔진이 관여하는 경우:

```dart
class GameOrchestrator {
  /// 경기 종료 시 복합 처리
  void finishMatch() {
    final match = _store.state.ui.activeMatch!;

    // 1. 경기 결과 처리 (MatchEngine)
    dispatch(const MatchAction(MatchActionType.finish));

    // 2. 순위표 업데이트 (LeagueEngine)
    dispatch(LeagueAction.updateStandings(
      MatchResult(
        homeTeamId: match.homeTeamId,
        awayTeamId: match.awayTeamId,
        homeScore: match.score.home,
        awayScore: match.score.away,
      ),
    ));

    // 3. AI 경기 시뮬레이션 (LeagueEngine)
    dispatch(const LeagueAction(LeagueActionType.simulateAIMatches));

    // 4. 커리어 업데이트 (CareerEngine)
    dispatch(CareerAction.recordMatch(match.ratingAccumulator));
    dispatch(CareerAction.addXP(_calculateXP(match)));
    dispatch(CareerAction.updateTrust(_calculateTrustDelta(match)));

    // 5. 라운드 진행 (LeagueEngine)
    dispatch(const LeagueAction(LeagueActionType.advanceRound));

    // 6. 이벤트 체크 (EventEngine) - 자동으로 checkSideEffects에서 처리
  }
}
```

### 7. 디렉토리 구조

```
lib/
├── domain/
│   ├── state/                    # 상태 정의
│   │   ├── game_state.dart       # Single Source of Truth
│   │   ├── player_state.dart
│   │   ├── season_state.dart
│   │   ├── league_state.dart
│   │   ├── event_state.dart
│   │   ├── transfer_state.dart
│   │   └── ui_state.dart
│   │
│   ├── action/                   # 액션 정의
│   │   ├── game_action.dart
│   │   ├── training_action.dart
│   │   ├── match_action.dart
│   │   ├── league_action.dart
│   │   ├── career_action.dart
│   │   ├── event_action.dart
│   │   └── transfer_action.dart
│   │
│   ├── engine/                   # 순수 함수 엔진
│   │   ├── training_engine.dart
│   │   ├── match_engine.dart
│   │   ├── league_engine.dart
│   │   ├── career_engine.dart
│   │   ├── event_engine.dart
│   │   └── transfer_engine.dart
│   │
│   └── model/                    # 도메인 모델
│       ├── player.dart
│       ├── team.dart
│       ├── match.dart
│       └── ...
│
├── application/
│   ├── orchestrator.dart         # 엔진 조합
│   ├── store.dart                # 상태 저장소
│   └── providers.dart            # Riverpod 프로바이더
│
├── data/
│   └── storage/
│       └── hive_store.dart       # 영속성
│
└── presentation/                 # UI (상태 구독만)
    └── ...
```

### 8. 데이터 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│                         사용자 입력                             │
│                    (버튼 클릭, 선택 등)                         │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌───────────────────────────────────────────────────────────────┐
│                   Presentation Layer                          │
│                   ══════════════════                          │
│  ref.read(orchestratorProvider).dispatch(TrainingAction(...)) │
└───────────────────────────┬───────────────────────────────────┘
                            │
                            ▼
┌───────────────────────────────────────────────────────────────┐
│                      GameOrchestrator                         │
│                      ════════════════                         │
│  1. 현재 상태 가져오기 (store.state)                          │
│  2. 적절한 엔진 선택                                          │
│  3. 새 상태 계산 (engine.process)                             │
│  4. 후속 처리 체크                                            │
│  5. 상태 업데이트 (store.update)                              │
└───────────────────────────┬───────────────────────────────────┘
                            │
                            ▼
┌───────────────────────────────────────────────────────────────┐
│                       GameStateStore                          │
│                       ══════════════                          │
│  - 상태 저장                                                  │
│  - notifyListeners()                                          │
│  - 자동 저장                                                  │
└───────────────────────────┬───────────────────────────────────┘
                            │
                            ▼
┌───────────────────────────────────────────────────────────────┐
│                    Presentation Layer                         │
│                    ══════════════════                         │
│  ref.watch(gameStateProvider) → UI 리빌드                     │
└───────────────────────────────────────────────────────────────┘
```

### 9. 테스트 전략

```dart
// 각 엔진을 독립적으로 테스트 가능
void main() {
  group('TrainingEngine', () {
    late TrainingEngine engine;

    setUp(() {
      engine = TrainingEngine();
    });

    test('shooting training increases shooting stat', () {
      final initialState = GameState.initial();
      final action = TrainingAction(TrainingType.shooting);
      final seed = 12345;  // 고정 시드로 결정적 테스트

      final newState = engine.process(initialState, action, seed);

      expect(
        newState.player.stats.shooting,
        greaterThan(initialState.player.stats.shooting),
      );
    });

    test('training reduces weekly actions', () {
      final initialState = GameState.initial();
      final action = TrainingAction(TrainingType.shooting);

      final newState = engine.process(initialState, action, 0);

      expect(
        newState.season.weeklyActionsRemaining,
        equals(initialState.season.weeklyActionsRemaining - 1),
      );
    });
  });

  group('MatchEngine', () {
    // 경기 엔진 테스트
  });

  group('Integration', () {
    test('full match flow', () {
      final orchestrator = GameOrchestrator(
        engines: [MatchEngine(), LeagueEngine(), CareerEngine()],
        store: GameStateStore(GameState.initial()),
      );

      orchestrator.dispatch(const MatchAction(MatchActionType.start));
      // ...
    });
  });
}
```

## 결과

### 긍정적 영향

1. **관심분리**: 각 엔진이 하나의 책임만 가짐
2. **Single Source of Truth**: 모든 상태가 `GameStateStore`에서만 관리
3. **테스트 용이**: 각 엔진을 고립된 환경에서 테스트 가능
4. **예측 가능**: 순수 함수 기반으로 같은 입력 → 같은 출력
5. **확장 용이**: 새 엔진 추가만으로 기능 확장
6. **디버깅 용이**: 액션 로그로 상태 변화 추적 가능

### 부정적 영향

1. **초기 리팩토링 비용**: 기존 코드 전면 재작성 필요
2. **보일러플레이트**: Action, State 정의 증가
3. **학습 곡선**: 새로운 패턴에 적응 필요

### 마이그레이션 전략

**Phase 1:**
- 새 아키텍처 기반 구조 생성
- TrainingEngine 먼저 분리

**Phase 2:**
- MatchEngine 분리
- LeagueEngine 분리

**Phase 3:**
- CareerEngine 분리
- 기존 GameController 제거

**Phase 4:**
- EventEngine 추가 (ADR-002)
- TransferEngine 추가 (ADR-001)

## 관련 문서
- [ADR-001: 이적 시스템](./ADR-001-transfer-career-system.md)
- [ADR-002: 스토리 이벤트 시스템](./ADR-002-story-event-system.md)
