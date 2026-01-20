/// 게임 상태 (Single Source of Truth)
///
/// 모든 게임 데이터의 유일한 원천.
/// 불변(Immutable) 객체로, 상태 변경은 copyWith로만 가능.

import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/player.dart';
import '../model/team.dart';
import '../model/match.dart';
import '../model/game_snapshot.dart' as snapshot;
import '../model/league.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

/// UI 화면 상태
enum UIScreen {
  boot,     // 로드/세이브 선택
  home,     // 홈 화면
  training, // 훈련 선택
  preMatch, // 경기 전
  match,    // 경기 중
  postMatch,// 경기 후
}

/// 게임 전체 상태 (Single Source of Truth)
@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    /// 플레이어 상태
    required PlayerState player,

    /// 시즌/리그 상태
    required SeasonState season,

    /// UI 상태
    required UIScreenState ui,

    /// 메타 정보
    required MetaState meta,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  /// 기존 GameSnapshot에서 변환
  factory GameState.fromSnapshot(snapshot.GameSnapshot snap) {
    return GameState(
      player: PlayerState(
        character: snap.pc,
        weeklyActionsRemaining: snap.weeklyActionsRemaining,
      ),
      season: SeasonState(
        id: snap.season.id,
        year: snap.season.year,
        currentRound: snap.season.currentRound,
        teams: snap.season.teams,
        fixtures: snap.season.fixtures,
        standings: snap.season.standings,
        leagueStats: snap.leagueStats,
      ),
      ui: UIScreenState(
        screen: _convertGameState(snap.gameState),
        activeMatch: snap.activeMatch,
      ),
      meta: MetaState(
        version: snap.version,
        savedAt: snap.savedAt,
      ),
    );
  }

  /// 기존 GameSnapshot으로 변환 (저장용)
  snapshot.GameSnapshot toSnapshot() {
    return snapshot.GameSnapshot(
      version: meta.version,
      savedAt: DateTime.now(),
      gameState: _convertUIScreen(ui.screen),
      pc: player.character,
      season: Season(
        id: season.id,
        year: season.year,
        currentRound: season.currentRound,
        teams: season.teams,
        fixtures: season.fixtures,
        standings: season.standings,
      ),
      activeMatch: ui.activeMatch,
      weeklyActionsRemaining: player.weeklyActionsRemaining,
      leagueStats: season.leagueStats,
    );
  }
}

/// 플레이어 상태
@freezed
class PlayerState with _$PlayerState {
  const PlayerState._();

  const factory PlayerState({
    /// 플레이어 캐릭터 (프로필, 스탯, 상태, 커리어)
    required PlayerCharacter character,

    /// 이번 주 남은 행동 횟수
    @Default(3) int weeklyActionsRemaining,
  }) = _PlayerState;

  factory PlayerState.fromJson(Map<String, dynamic> json) =>
      _$PlayerStateFromJson(json);

  /// 행동 가능 여부
  bool get canTakeAction => weeklyActionsRemaining > 0;

  /// PC 팀 ID
  String get teamId => character.profile.teamId;

  /// PC 스탯 (간편 접근)
  PlayerStats get stats => character.stats;

  /// PC 상태 (간편 접근)
  PlayerStatus get status => character.status;

  /// PC 커리어 (간편 접근)
  PlayerCareer get career => character.career;
}

/// 시즌/리그 상태
@freezed
class SeasonState with _$SeasonState {
  const SeasonState._();

  const factory SeasonState({
    required String id,
    required int year,
    @Default(1) int currentRound,

    /// 팀 데이터 (유일한 원천)
    required Map<String, Team> teams,

    /// 경기 일정
    required List<Fixture> fixtures,

    /// 순위표
    required List<StandingRow> standings,

    /// 개인 순위용 리그 통계
    LeagueStats? leagueStats,
  }) = _SeasonState;

  factory SeasonState.fromJson(Map<String, dynamic> json) =>
      _$SeasonStateFromJson(json);

  /// 정렬된 순위표 반환 (승점 > 골득실 > 득점)
  List<StandingRow> get sortedStandings {
    final sorted = [...standings];
    sorted.sort((a, b) {
      final pointsCompare = b.points.compareTo(a.points);
      if (pointsCompare != 0) return pointsCompare;
      final gdCompare = b.goalDifference.compareTo(a.goalDifference);
      if (gdCompare != 0) return gdCompare;
      return b.goalsFor.compareTo(a.goalsFor);
    });
    return sorted;
  }

  /// 다음 경기 가져오기
  Fixture? getNextFixture(String teamId) {
    try {
      return fixtures.firstWhere(
        (f) => !f.isPlayed && (f.homeTeamId == teamId || f.awayTeamId == teamId),
      );
    } catch (_) {
      return null;
    }
  }

  /// 특정 라운드 경기 목록
  List<Fixture> getFixturesForRound(int round) {
    return fixtures.where((f) => f.round == round).toList();
  }

  /// 팀 ID로 팀 조회
  Team? getTeam(String teamId) => teams[teamId];

  /// PC 순위
  int getRank(String teamId) {
    final sorted = sortedStandings;
    return sorted.indexWhere((s) => s.teamId == teamId) + 1;
  }
}

/// UI 화면 상태
@freezed
class UIScreenState with _$UIScreenState {
  const UIScreenState._();

  const factory UIScreenState({
    /// 현재 화면
    @Default(UIScreen.boot) UIScreen screen,

    /// 진행 중인 경기 (있을 경우)
    MatchSession? activeMatch,
  }) = _UIScreenState;

  factory UIScreenState.fromJson(Map<String, dynamic> json) =>
      _$UIScreenStateFromJson(json);

  /// 경기 중인지
  bool get isInMatch => activeMatch != null;
}

/// 메타 정보
@freezed
class MetaState with _$MetaState {
  const factory MetaState({
    @Default(1) int version,
    required DateTime savedAt,
  }) = _MetaState;

  factory MetaState.fromJson(Map<String, dynamic> json) =>
      _$MetaStateFromJson(json);
}

/// 기존 GameState enum을 UIScreen으로 변환
UIScreen _convertGameState(snapshot.GameState gs) {
  return switch (gs) {
    snapshot.GameState.boot => UIScreen.boot,
    snapshot.GameState.home => UIScreen.home,
    snapshot.GameState.training => UIScreen.training,
    snapshot.GameState.preMatch => UIScreen.preMatch,
    snapshot.GameState.match => UIScreen.match,
    snapshot.GameState.postMatch => UIScreen.postMatch,
  };
}

/// UIScreen을 기존 GameState enum으로 변환
snapshot.GameState _convertUIScreen(UIScreen screen) {
  return switch (screen) {
    UIScreen.boot => snapshot.GameState.boot,
    UIScreen.home => snapshot.GameState.home,
    UIScreen.training => snapshot.GameState.training,
    UIScreen.preMatch => snapshot.GameState.preMatch,
    UIScreen.match => snapshot.GameState.match,
    UIScreen.postMatch => snapshot.GameState.postMatch,
  };
}
