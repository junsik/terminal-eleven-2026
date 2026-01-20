import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../widgets/retro_theme.dart';

class TeamSelectionScreen extends ConsumerStatefulWidget {
  final String playerName;
  final PlayerPosition position;
  final PlayerArchetype archetype;

  const TeamSelectionScreen({
    super.key,
    required this.playerName,
    required this.position,
    required this.archetype,
  });

  @override
  ConsumerState<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends ConsumerState<TeamSelectionScreen> {
  final _leagues = ['K-League 1', 'K-League 2 (미구현)']; // 예시
  String _selectedLeague = 'K-League 1';
  final _teams = LeagueData.createDefaultTeams();
  String? _selectedTeamId;

  @override
  void initState() {
    super.initState();
    _selectedTeamId = _teams[0].id; // Default selection
  }

  void _onStart() {
    if (_selectedTeamId == null) return;

    // 새 아키텍처로 게임 시작
    ref.read(orchestratorProvider).startNewCareer(
          playerName: widget.playerName,
          archetype: widget.archetype.name,
          teamId: _selectedTeamId!,
        );

    // 홈으로 이동
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('팀 선택'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: RetroColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 4. 리그 선택
              Text(
                '4. 리그 선택',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: RetroColors.primary,
                    ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: RetroColors.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: _selectedLeague,
                  isExpanded: true,
                  dropdownColor: RetroColors.surface,
                  underline: const SizedBox(),
                  style: const TextStyle(
                    color: RetroColors.textPrimary,
                    fontFamily: 'JetBrainsMono',
                  ),
                  items: _leagues.map((league) {
                    final isEnabled = league == 'K-League 1';
                    return DropdownMenuItem(
                      value: league,
                      enabled: isEnabled,
                      child: Text(
                        league,
                        style: TextStyle(
                          color: isEnabled ? RetroColors.textPrimary : RetroColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLeague = value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 5. 팀 선택
              Text(
                '5. 팀 선택',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: RetroColors.primary,
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _teams.length,
                itemBuilder: (context, index) {
                  final team = _teams[index];
                  final isSelected = _selectedTeamId == team.id;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedTeamId = team.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? RetroColors.primary.withAlpha(25) : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? RetroColors.primary : RetroColors.divider,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: RetroColors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(color: RetroColors.divider),
                            ),
                            child: Center(
                              child: Text(
                                team.name.substring(0, 1),
                                style: const TextStyle(
                                  color: RetroColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  team.name,
                                  style: TextStyle(
                                    color: isSelected ? RetroColors.primary : RetroColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _buildRatingBadge('OVR', team.overallRating),
                                    const SizedBox(width: 8),
                                    _buildRatingBadge('ATT', team.attackRating),
                                    const SizedBox(width: 8),
                                    _buildRatingBadge('DEF', team.defenseRating),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: RetroColors.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // 시작 버튼
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RetroColors.primary,
                    foregroundColor: RetroColors.background,
                  ),
                  child: const Text(
                    '커리어 시작하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBadge(String label, int rating) {
    Color color = RetroColors.textSecondary;
    if (rating >= 75) color = Colors.green;
    else if (rating >= 70) color = Colors.blue;
    else if (rating >= 60) color = Colors.orange;
    else color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: color.withAlpha(100), width: 0.5),
      ),
      child: Text(
        '$label $rating',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
