/// 기본 엔진 추상 클래스
///
/// 모든 엔진은 순수 함수로 구현된다.
/// (State, Action, Seed) → State'

import '../state/game_state.dart';
import '../action/game_action.dart';

/// 게임 엔진 인터페이스
///
/// 모든 엔진은 이 인터페이스를 구현한다.
/// - canHandle: 이 엔진이 처리할 수 있는 액션인지 확인
/// - process: 액션을 처리하고 새 상태 반환 (순수 함수)
abstract class GameEngine<A extends GameAction> {
  /// 이 엔진이 처리할 수 있는 액션인지 확인
  bool canHandle(GameAction action);

  /// 액션을 처리하고 새 상태 반환
  ///
  /// 순수 함수: 같은 입력이면 항상 같은 출력
  /// - [state]: 현재 게임 상태
  /// - [action]: 처리할 액션
  /// - [seed]: 랜덤 시드 (결정적 랜덤을 위해)
  ///
  /// Returns: 새로운 불변 GameState
  GameState process(GameState state, A action, int seed);
}

/// 엔진 처리 결과
///
/// 엔진이 처리한 결과를 담는 래퍼
/// 새 상태와 함께 추가 정보(메시지 등)를 전달할 수 있음
class EngineResult {
  final GameState state;
  final String? message;
  final List<GameAction> followUpActions;

  const EngineResult({
    required this.state,
    this.message,
    this.followUpActions = const [],
  });

  /// 단순 상태 반환
  factory EngineResult.simple(GameState state) => EngineResult(state: state);

  /// 메시지와 함께 반환
  factory EngineResult.withMessage(GameState state, String message) =>
      EngineResult(state: state, message: message);

  /// 후속 액션과 함께 반환
  factory EngineResult.withFollowUp(
    GameState state,
    List<GameAction> actions,
  ) =>
      EngineResult(state: state, followUpActions: actions);
}

/// 처리되지 않은 액션 예외
class UnhandledActionException implements Exception {
  final GameAction action;
  final String message;

  UnhandledActionException(this.action, [String? msg])
      : message = msg ?? 'No engine can handle action: ${action.runtimeType}';

  @override
  String toString() => 'UnhandledActionException: $message';
}
