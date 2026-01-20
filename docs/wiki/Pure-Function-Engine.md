# Pure Function Engine

## 개념

Terminal Eleven의 모든 게임 로직은 **순수 함수(Pure Function)** 패턴으로 구현됩니다.

```dart
// 순수 함수의 시그니처
GameState process(GameState state, GameAction action, int seed);
```

## 순수 함수란?

순수 함수는 다음 조건을 만족하는 함수입니다:

1. **결정론적**: 같은 입력이면 항상 같은 출력
2. **부작용 없음**: 외부 상태를 변경하지 않음
3. **참조 투명성**: 함수 호출을 결과값으로 대체 가능

## 왜 순수 함수인가?

### 테스트 용이성
```dart
test('슈팅 훈련은 슈팅 스탯을 올린다', () {
  final state = createTestState();
  final action = ExecuteTraining(TrainingType.shooting);

  final newState = engine.process(state, action, seed: 42);

  expect(newState.player.stats.shooting, greaterThan(state.player.stats.shooting));
});
```

### 결정론적 결과
같은 시드를 사용하면 항상 같은 결과:
```dart
// 시드 42로 실행하면 항상 같은 결과
final result1 = engine.process(state, action, seed: 42);
final result2 = engine.process(state, action, seed: 42);
assert(result1 == result2); // 항상 true
```

### 리플레이 가능
경기를 다시 재생하거나 버그 재현 가능:
```dart
// 액션 로그만 저장하면 전체 게임 재현 가능
final actionLog = [action1, action2, action3, ...];
var state = initialState;
for (final action in actionLog) {
  state = engine.process(state, action, seed);
}
```

## 엔진 구조

### Base Engine
```dart
abstract class GameEngine<T extends GameAction> {
  bool canHandle(GameAction action);
  GameState process(GameState state, T action, int seed);
}
```

### Training Engine
```dart
class TrainingEngine extends GameEngine<TrainingAction> {
  @override
  bool canHandle(GameAction action) => action is TrainingAction;

  @override
  GameState process(GameState state, TrainingAction action, int seed) {
    // 훈련 로직 (순수 함수)
    final random = Random(seed);
    final statGain = calculateStatGain(action.type, random);

    return state.copyWith(
      player: state.player.copyWith(
        stats: state.player.stats.copyWith(
          shooting: state.player.stats.shooting + statGain,
        ),
      ),
    );
  }
}
```

### Match Engine
```dart
class MatchEngine extends GameEngine<MatchAction> {
  @override
  GameState process(GameState state, MatchAction action, int seed) {
    // 경기 로직 (순수 함수)
    final resolver = HighlightResolver(seed: seed);
    final result = resolver.resolve(
      event: currentHighlight,
      command: action.command,
      stats: state.player.stats,
      // ...
    );

    return state.copyWith(
      activeMatch: state.activeMatch!.copyWith(
        score: newScore,
        // ...
      ),
    );
  }
}
```

## 랜덤 처리

게임에서 랜덤이 필요한 경우 **시드 기반 랜덤**을 사용:

```dart
// 시드로 Random 생성
final random = Random(seed);

// 이 random 사용 → 같은 시드면 같은 결과
final roll = random.nextDouble();
final success = roll < probability;
```

## Freezed와의 조합

불변 객체(Immutable)와 순수 함수의 조합:

```dart
@freezed
class GameState with _$GameState {
  const factory GameState({
    required PlayerState player,
    required SeasonState season,
    // ...
  }) = _GameState;
}

// copyWith로 새 상태 생성 (원본 불변)
final newState = state.copyWith(
  player: state.player.copyWith(/* ... */),
);
```

---

다음: [[밸런스 설정|Balance-Config]]
