// 로비 화면 - 새 게임 시작 / 이어하기

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../domain/state/game_state.dart' as engine;
import '../../data/storage/hive_store.dart';
import '../../presentation/widgets/retro_theme.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({super.key});

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  final _nameController = TextEditingController();
  PlayerArchetype _selectedArchetype = PlayerArchetype.poacher;
  String _selectedTeamId = 'team_10'; // 광주 FC (약팀에서 시작)
  bool _hasSavedGame = false;
  bool _isLoading = true;

  final _teams = LeagueData.createDefaultTeams();

  @override
  void initState() {
    super.initState();
    _checkSavedGame();
  }

  Future<void> _checkSavedGame() async {
    final hasSave = await gameStorage.hasSavedGame();
    if (mounted) {
      setState(() {
        _hasSavedGame = hasSave;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startGame() {
    context.push('/new_game/character');
  }

  Future<void> _continueGame() async {
    final snapshot = await gameStorage.loadSnapshot();
    if (snapshot != null) {
      // 새 아키텍처: GameStateStore에 상태 로드
      final gameState = engine.GameState.fromSnapshot(snapshot);
      ref.read(gameStateStoreProvider).initialize(gameState);
      if (mounted) {
        context.go('/home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장된 게임을 불러올 수 없습니다')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: RetroColors.background,
        body: Center(
          child: CircularProgressIndicator(color: RetroColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: RetroColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 타이틀
              Text(
                'MUD 축구',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '무명에서 스타로',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: RetroColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // 이어하기 버튼 (저장된 게임이 있을 때만)
              if (_hasSavedGame) ...[
                ElevatedButton(
                  onPressed: _continueGame,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('이어하기', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 24),
              ],

              // 새 게임 시작 버튼
              OutlinedButton(
                onPressed: _startGame,
                style: OutlinedButton.styleFrom(
                   padding: const EdgeInsets.symmetric(vertical: 16),
                   side: const BorderSide(color: RetroColors.primary, width: 2),
                ),
                child: const Text('새 게임 시작', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
