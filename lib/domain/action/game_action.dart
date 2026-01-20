/// 게임 액션 정의
///
/// 모든 상태 변경은 Action을 통해 발생한다.
/// Action → Engine → 새 State

import '../model/game_snapshot.dart' show TrainingType, TrainingIntensity;
import '../model/command.dart';

/// 모든 게임 액션의 기본 클래스
sealed class GameAction {
  const GameAction();
}

// ============================================================================
// Training Actions
// ============================================================================

/// 훈련 관련 액션
sealed class TrainingAction extends GameAction {
  const TrainingAction();
}

/// 훈련 실행
class ExecuteTraining extends TrainingAction {
  final TrainingType type;
  final TrainingIntensity intensity;
  const ExecuteTraining(this.type, {this.intensity = TrainingIntensity.normal});
}

// ============================================================================
// Match Actions
// ============================================================================

/// 경기 관련 액션
sealed class MatchAction extends GameAction {
  const MatchAction();
}

/// 경기 시작
class StartMatch extends MatchAction {
  const StartMatch();
}

/// 인트로에서 진행
class ProceedFromIntro extends MatchAction {
  const ProceedFromIntro();
}

/// 하이라이트 선택 처리
class ProcessHighlightChoice extends MatchAction {
  final CommandType command;
  const ProcessHighlightChoice(this.command);
}

/// 다음 하이라이트로 진행
class ProceedToNextHighlight extends MatchAction {
  const ProceedToNextHighlight();
}

/// 경기 종료 처리
class FinishMatch extends MatchAction {
  const FinishMatch();
}

/// 전술 외침 실행 (New)
class ExecuteTacticalShout extends MatchAction {
  final CommandType shoutType;
  const ExecuteTacticalShout(this.shoutType);
}

/// 경기 관전 (부상 시)
class SpectateMatch extends MatchAction {
  const SpectateMatch();
}

// ============================================================================
// League Actions
// ============================================================================

/// 리그 관련 액션
sealed class LeagueAction extends GameAction {
  const LeagueAction();
}

/// 순위표 업데이트
class UpdateStandings extends LeagueAction {
  final MatchResultData result;
  const UpdateStandings(this.result);
}

/// AI 경기 시뮬레이션
class SimulateAIMatches extends LeagueAction {
  final int round;
  const SimulateAIMatches(this.round);
}

/// 라운드 진행
class AdvanceRound extends LeagueAction {
  const AdvanceRound();
}

/// 주간 액션 리셋
class ResetWeeklyActions extends LeagueAction {
  const ResetWeeklyActions();
}

/// 픽스처 업데이트
class UpdateFixture extends LeagueAction {
  final String fixtureId;
  final int homeScore;
  final int awayScore;

  const UpdateFixture({
    required this.fixtureId,
    required this.homeScore,
    required this.awayScore,
  });
}

/// PC 팀 경기 결과 업데이트 (픽스처 + 순위표)
class RecordPCMatchResult extends LeagueAction {
  final String fixtureId;
  final MatchResultData result;

  const RecordPCMatchResult({
    required this.fixtureId,
    required this.result,
  });
}

// ============================================================================
// Career Actions
// ============================================================================

/// 커리어 관련 액션
sealed class CareerAction extends GameAction {
  const CareerAction();
}

/// XP 추가
class AddXP extends CareerAction {
  final int amount;
  const AddXP(this.amount);
}

/// 레벨업
class LevelUp extends CareerAction {
  const LevelUp();
}

/// 신뢰도 업데이트
class UpdateTrust extends CareerAction {
  final int delta;
  const UpdateTrust(this.delta);
}

/// 평판 업데이트
class UpdateReputation extends CareerAction {
  final int delta;
  const UpdateReputation(this.delta);
}

/// 경기 기록 저장
class RecordMatchStats extends CareerAction {
  final double rating;
  final int goals;
  final int assists;
  const RecordMatchStats({
    required this.rating,
    required this.goals,
    required this.assists,
  });
}

// ============================================================================
// UI Actions
// ============================================================================

/// UI 관련 액션
sealed class UIAction extends GameAction {
  const UIAction();
}

/// 홈 화면으로 이동
class GoToHome extends UIAction {
  const GoToHome();
}

/// 훈련 화면으로 이동
class GoToTraining extends UIAction {
  const GoToTraining();
}

/// 경기 전 화면으로 이동
class GoToPreMatch extends UIAction {
  const GoToPreMatch();
}

/// 화면 설정 (내부용)
class SetScreen extends UIAction {
  final int screenIndex; // UIScreen enum index
  const SetScreen(this.screenIndex);
}

/// 활성 경기 설정 (내부용)
class SetActiveMatch extends UIAction {
  final bool clear;
  const SetActiveMatch({this.clear = false});
}

/// 경기 후 화면으로 이동
class GoToPostMatch extends UIAction {
  const GoToPostMatch();
}

// ============================================================================
// Inbox Actions
// ============================================================================

/// 인박스 관련 액션
sealed class InboxAction extends GameAction {
  const InboxAction();
}

/// 메시지 추가
class AddInboxMessage extends InboxAction {
  final String senderType; // coach, agent, fan, media, system
  final String category; // welcome, training, matchResult, levelUp, etc.
  final String subject;
  final String content;
  final String? customSenderName;

  const AddInboxMessage({
    required this.senderType,
    required this.category,
    required this.subject,
    required this.content,
    this.customSenderName,
  });
}

/// 메시지 읽음 처리
class MarkMessageAsRead extends InboxAction {
  final String messageId;
  const MarkMessageAsRead(this.messageId);
}

/// 모든 메시지 읽음 처리
class MarkAllMessagesAsRead extends InboxAction {
  const MarkAllMessagesAsRead();
}

/// 메시지 삭제
class DeleteInboxMessage extends InboxAction {
  final String messageId;
  const DeleteInboxMessage(this.messageId);
}

// ============================================================================
// System Actions
// ============================================================================

/// 시스템 관련 액션
sealed class SystemAction extends GameAction {
  const SystemAction();
}

/// 새 게임 시작
class StartNewGame extends SystemAction {
  final String playerName;
  final String archetype;
  final String teamId;
  const StartNewGame({
    required this.playerName,
    required this.archetype,
    required this.teamId,
  });
}

/// 게임 로드
class LoadGame extends SystemAction {
  const LoadGame();
}

/// 게임 저장
class SaveGame extends SystemAction {
  const SaveGame();
}

// ============================================================================
// Helper Types
// ============================================================================

/// 경기 결과 데이터 (순위표 업데이트용)
class MatchResultData {
  final String homeTeamId;
  final String awayTeamId;
  final int homeScore;
  final int awayScore;

  const MatchResultData({
    required this.homeTeamId,
    required this.awayTeamId,
    required this.homeScore,
    required this.awayScore,
  });

  bool get isHomeWin => homeScore > awayScore;
  bool get isAwayWin => awayScore > homeScore;
  bool get isDraw => homeScore == awayScore;
}
