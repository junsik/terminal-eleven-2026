
import 'package:flutter_test/flutter_test.dart';
import 'package:mud_soccer_player/application/orchestrator.dart';
import 'package:mud_soccer_player/domain/model/models.dart';
import 'package:mud_soccer_player/domain/state/game_state.dart' as new_state;
import 'package:mud_soccer_player/domain/state/game_state.dart' show UIScreen;
import 'package:mud_soccer_player/domain/engine/league_simulator.dart';
import 'package:uuid/uuid.dart';

/// Headless Simulation for GameOrchestrator
void main() {
  test('Orchestrator Full Season Simulation', () async {
    // 1. Setup
    final store = GameStateStore();
    final orchestrator = GameOrchestrator(store: store, seed: 12345);

    // Initialize Game State (New Career)
    final initialState = _createInitialState();
    store.initialize(initialState);
    
    // Validate initialization
    expect(orchestrator.state, isNotNull);
    final startState = orchestrator.state!;
    print('🚀 Starting Simulation: Season ${startState.season.year}');
    print('Player: ${startState.player.character.profile.name}');
    
    // 2. Simulation Loop (Play 3 Rounds)
    for (int round = 1; round <= 3; round++) {
      print('\n--- Round $round Start ---');

      // A. Training Phase
      while (orchestrator.state!.player.weeklyActionsRemaining > 0) {
        // Simple training strategy
        orchestrator.executeTraining(TrainingType.shooting);
      }
      print('Training completed. Fatigue: ${orchestrator.state!.player.character.status.fatigue}');

      // B. Match Phase
      final playerTeamId = orchestrator.state!.player.teamId;
      final nextFixture = orchestrator.state!.season.getNextFixture(playerTeamId);
      
      if (nextFixture != null) {
         final opponentId = nextFixture.homeTeamId == playerTeamId 
             ? nextFixture.awayTeamId 
             : nextFixture.homeTeamId;
         final opponent = orchestrator.state!.season.teams[opponentId];
         
        print('Starting Match vs ${opponent?.name}');
        orchestrator.startMatch();

        // Match Loop
        // Note: activeMatch can be null immediately if injured, so check IsInMatch
        while (orchestrator.state!.ui.isInMatch) {
          final match = orchestrator.state!.ui.activeMatch!;
          
          if (match.phase == MatchPhase.intro) {
            orchestrator.proceedFromIntro();
          } else if (match.phase == MatchPhase.highlightPresent) {
             // Deterministic check: shout every 10 minutes if not shouted
             if (match.lastShoutIndex != match.currentHighlightIndex && match.currentHighlight!.minute % 10 == 0) {
               print('🗣️ Shouting Encourage!');
               orchestrator.executeTacticalShout(CommandType.shoutEncourage);
               // Note: phase stays highlightPresent, loop continues
               continue;
             }
             
             final choices = match.currentHighlight!.choices;
             // Try Panenka if available to test new feature
             if (choices.contains('panenka')) {
               print('👉 Attempting Panenka!');
               orchestrator.processHighlightChoice(CommandType.panenka);
             } else if (choices.contains('shoot')) {
               orchestrator.processHighlightChoice(CommandType.shoot);
             } else if (choices.isNotEmpty) {
               // Fallback to first available
               final cmd = commandTypeFromString(choices.first);
               if (cmd != null) orchestrator.processHighlightChoice(cmd);
             }
          } else if (match.phase == MatchPhase.highlightResult) {
            orchestrator.proceedToNextHighlight();
          } else if (match.phase == MatchPhase.fullTime) {
            print('Match Finished. Score: ${match.score.home}-${match.score.away}');
            orchestrator.finishMatch(); 
            // finishMatch transitions state to postMatch, then updates standings, etc.
            // and finally likely goes to Home.
            break; 
          }
        }
      } else {
        print('No fixture for this round.');
        // If no fixture, we still need to advance round? 
        // In this simple loop, we assume 1 round = 1 match. 
        // If logic differs, we might get stuck efficiently. 
        // For now, let's just break to confirm basic functionality.
      }
      
      // Verify state after match
      final currentState = orchestrator.state!;
      print('Round End State: Rank ${currentState.season.getRank(playerTeamId)}');

      // 🔑 개인 순위 확인
      final leagueStats = currentState.season.leagueStats;
      if (leagueStats != null) {
        final topScorers = leagueStats.goalRanking(5);
        print('Top 5 Scorers:');
        for (final player in topScorers) {
          print('  ${player.name} (${player.teamId}): ${player.goals} goals, ${player.assists} assists');
        }
      } else {
        print('⚠️ LeagueStats is null!');
      }
    }

    // 🔑 Final verification
    final finalState = orchestrator.state!;
    final leagueStats = finalState.season.leagueStats;
    expect(leagueStats, isNotNull, reason: 'LeagueStats should not be null');

    // Check that AI players have stats
    final playersWithGoals = leagueStats!.players.where((p) => p.goals > 0).length;
    final playersWithMatches = leagueStats.players.where((p) => p.matchesPlayed > 0).length;
    print('\n📊 Final Stats:');
    print('  Players with goals: $playersWithGoals');
    print('  Players with matches: $playersWithMatches');
    print('  PC Goals: ${finalState.player.career.totalGoals}');
    print('  PC Assists: ${finalState.player.career.totalAssists}');

    expect(playersWithMatches, greaterThan(0), reason: 'AI players should have played matches');

    print('\n✅ Simulation Complete.');
  });
}

// Create correct GameState object
new_state.GameState _createInitialState() {
  final uuid = const Uuid();
  
  // Teams
  final teams = LeagueData.createDefaultTeams();
  final Map<String, Team> teamMap = {for (final t in teams) t.id: t};
  final myTeamId = teams[0].id;

  // Player
  final pc = PlayerCharacter.create(
    id: uuid.v4(),
    name: "SimUser",
    position: PlayerPosition.forward,
    archetype: PlayerArchetype.poacher,
    teamId: myTeamId,
  );

  // Season
  final fixtures = LeagueData.createFixtures(teams);
  final standings = LeagueData.createInitialStandings(teams);

  // 🔑 LeagueStats 초기화
  final simulator = LeagueSimulator(seed: 12345);
  final leagueStats = simulator.initializeLeague(teams, pc.profile.id, myTeamId);

  return new_state.GameState(
    player: new_state.PlayerState(
      character: pc,
      weeklyActionsRemaining: 3,
    ),
    season: new_state.SeasonState(
      id: uuid.v4(),
      year: 2024,
      teams: teamMap,
      fixtures: fixtures,
      standings: standings,
      currentRound: 1,
      leagueStats: leagueStats,
    ),
    ui: const new_state.UIScreenState(
      screen: UIScreen.home,
    ),
    meta: new_state.MetaState(
      savedAt: DateTime.now(),
    ),
  );
}
