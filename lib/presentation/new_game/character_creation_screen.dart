import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/models.dart';
import '../widgets/retro_theme.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() => _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  final _nameController = TextEditingController();
  PlayerPosition _selectedPosition = PlayerPosition.forward;
  PlayerArchetype _selectedArchetype = PlayerArchetype.poacher;

  @override
  void initState() {
    super.initState();
    // 초기화 시 포지션에 맞는 첫 번째 아키타입 선택
    _updateArchetypeForPosition(_selectedPosition);
  }

  void _updateArchetypeForPosition(PlayerPosition position) {
    setState(() {
      _selectedPosition = position;
      _selectedArchetype = position.archetypes.first;
    });
  }

  void _onNext() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('선수 이름을 입력하세요')),
      );
      return;
    }

    context.push(
      '/new_game/team',
      extra: {
        'name': _nameController.text,
        'position': _selectedPosition,
        'archetype': _selectedArchetype,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('캐릭터 생성'),
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
              // 1. 이름 입력
              Text(
                '1. 이름 입력',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: RetroColors.primary,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: RetroColors.textPrimary),
                decoration: InputDecoration(
                  hintText: '선수 이름을 입력하세요...',
                  hintStyle: TextStyle(color: RetroColors.textSecondary.withAlpha(100)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: RetroColors.divider),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: RetroColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 2. 포지션 선택
              Text(
                '2. 포지션 선택',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: RetroColors.primary,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  PlayerPosition.forward,
                  PlayerPosition.midfielder,
                  PlayerPosition.defender,
                ].map((position) {
                  final isSelected = _selectedPosition == position;
                  return ChoiceChip(
                    label: Text(position.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _updateArchetypeForPosition(position);
                      }
                    },
                    selectedColor: RetroColors.primary.withAlpha(50),
                    backgroundColor: Colors.transparent,
                    labelStyle: TextStyle(
                      color: isSelected ? RetroColors.primary : RetroColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(
                        color: isSelected ? RetroColors.primary : RetroColors.divider,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // 3. 플레이 스타일 선택
              Text(
                '3. 플레이 스타일 선택',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: RetroColors.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '선택한 포지션에 따른 플레이 스타일입니다.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: RetroColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedPosition.archetypes.map((archetype) {
                  final isSelected = _selectedArchetype == archetype;
                  return ChoiceChip(
                    label: Text(archetype.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedArchetype = archetype);
                      }
                    },
                    selectedColor: RetroColors.primary.withAlpha(50),
                    backgroundColor: Colors.transparent,
                    labelStyle: TextStyle(
                      color: isSelected ? RetroColors.primary : RetroColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(
                        color: isSelected ? RetroColors.primary : RetroColors.divider,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              
              // 스타일 설명
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: RetroColors.surface,
                  border: Border.all(color: RetroColors.divider),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedArchetype.label,
                      style: const TextStyle(
                        color: RetroColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedArchetype.description,
                      style: const TextStyle(
                        color: RetroColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // 다음 버튼
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RetroColors.primary,
                    foregroundColor: RetroColors.background,
                  ),
                  child: const Text(
                    '다음 단계 (팀 선택)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
