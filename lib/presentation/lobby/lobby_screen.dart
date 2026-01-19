// 로비 화면 - 새 게임 시작 / 이어하기

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
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
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('선수 이름을 입력하세요')),
      );
      return;
    }

    ref.read(gameControllerProvider.notifier).startNewCareer(
          playerName: _nameController.text,
          archetype: _selectedArchetype,
          teamId: _selectedTeamId,
        );

    context.go('/home');
  }

  Future<void> _continueGame() async {
    final snapshot = await gameStorage.loadSnapshot();
    if (snapshot != null) {
      ref.read(gameControllerProvider.notifier).loadGame(snapshot);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
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
              const SizedBox(height: 32),

              // 이어하기 버튼 (저장된 게임이 있을 때만)
              if (_hasSavedGame) ...[
                ElevatedButton(
                  onPressed: _continueGame,
                  child: const Text('이어하기'),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
              ],

              // 새 게임 섹션
              Text(
                '새 게임',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // 선수 이름
              Text(
                '> 선수 이름',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: RetroColors.primary),
                decoration: const InputDecoration(
                  hintText: '이름 입력...',
                ),
              ),
              const SizedBox(height: 24),

              // 아키타입 선택
              Text(
                '> 플레이 스타일',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: PlayerArchetype.values.map((archetype) {
                  final isSelected = _selectedArchetype == archetype;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedArchetype = archetype),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? RetroColors.primary
                              : RetroColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        color: isSelected
                            ? RetroColors.primary.withAlpha(25)
                            : Colors.transparent,
                      ),
                      child: Text(
                        _archetypeName(archetype),
                        style: TextStyle(
                          color: isSelected
                              ? RetroColors.primary
                              : RetroColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Text(
                _archetypeDescription(_selectedArchetype),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),

              // 팀 선택
              Text(
                '> 소속 팀',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: RetroColors.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: _selectedTeamId,
                  isExpanded: true,
                  dropdownColor: RetroColors.surface,
                  underline: const SizedBox(),
                  style: const TextStyle(
                    color: RetroColors.primary,
                    fontFamily: 'JetBrainsMono',
                  ),
                  items: _teams.map((team) {
                    return DropdownMenuItem(
                      value: team.id,
                      child: Text('${team.name} (OVR: ${team.overallRating})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedTeamId = value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 시작 버튼
              OutlinedButton(
                onPressed: _startGame,
                child: const Text('커리어 시작'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String _archetypeName(PlayerArchetype archetype) {
    switch (archetype) {
      case PlayerArchetype.poacher:
        return '포처';
      case PlayerArchetype.speedster:
        return '스피드스터';
      case PlayerArchetype.pressingForward:
        return '프레싱 FW';
      case PlayerArchetype.targetMan:
        return '타겟맨';
    }
  }

  String _archetypeDescription(PlayerArchetype archetype) {
    switch (archetype) {
      case PlayerArchetype.poacher:
        return '슈팅과 위치선정이 뛰어남. 골 결정력이 강점.';
      case PlayerArchetype.speedster:
        return '빠른 속도로 돌파. 역습에 강함.';
      case PlayerArchetype.pressingForward:
        return '끊임없는 압박과 활동량. 체력이 강점.';
      case PlayerArchetype.targetMan:
        return '피지컬과 침착성이 뛰어남. 공중볼에 강함.';
    }
  }
}
