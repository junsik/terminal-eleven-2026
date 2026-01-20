/// UI 엔진
///
/// UI 화면 전환 관련 로직만 담당하는 순수 함수 엔진
/// - 화면 전환
/// - 활성 경기 관리

import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';

/// UI 엔진
class UIEngine extends GameEngine<UIAction> {
  @override
  bool canHandle(GameAction action) => action is UIAction;

  @override
  GameState process(GameState state, UIAction action, int seed) {
    return switch (action) {
      GoToHome() => _goToHome(state),
      GoToTraining() => _goToTraining(state),
      GoToPreMatch() => _goToPreMatch(state),
      GoToPostMatch() => _goToPostMatch(state),
      SetScreen() => state, // TODO: 구현 필요
      SetActiveMatch() => state, // TODO: 구현 필요
    };
  }

  /// 경기 후 화면으로 이동
  GameState _goToPostMatch(GameState state) {
    return state.copyWith(
      ui: state.ui.copyWith(screen: UIScreen.postMatch),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 홈 화면으로 이동
  GameState _goToHome(GameState state) {
    return state.copyWith(
      ui: state.ui.copyWith(
        screen: UIScreen.home,
        activeMatch: null, // 활성 경기 초기화
      ),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 훈련 화면으로 이동
  GameState _goToTraining(GameState state) {
    return state.copyWith(
      ui: state.ui.copyWith(screen: UIScreen.training),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 경기 전 화면으로 이동
  GameState _goToPreMatch(GameState state) {
    return state.copyWith(
      ui: state.ui.copyWith(screen: UIScreen.preMatch),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }
}
