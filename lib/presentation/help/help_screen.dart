// 게임 도움말 화면

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/retro_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('게임 도움말'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: '게임 개요',
            icon: Icons.sports_soccer,
            content: '''
프로 축구 선수가 되어 커리어를 쌓아가는 시뮬레이션 게임입니다.

매주 훈련으로 능력치를 올리고, 경기에서 활약하여 팀 승리에 기여하세요.
시즌이 끝나면 순위에 따라 보상을 받고, 더 높은 곳을 향해 도전하세요.''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '주간 사이클',
            icon: Icons.calendar_today,
            content: '''
• 매주 3회의 행동 기회가 주어집니다
• 훈련으로 스탯을 올리거나, 휴식으로 피로를 회복하세요
• 행동을 모두 소진하지 않아도 경기 참여가 가능합니다
• 경기 후 다음 주로 넘어가며 행동이 리셋됩니다''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '피로 시스템',
            icon: Icons.battery_alert,
            content: '''
피로는 경기력에 직접적인 영향을 줍니다.

• 0~60: 정상 상태
• 61~80: 성공률 감소 (-0.3%/피로)
• 81~100: 과로 상태
  - 성공률 대폭 감소 (-0.6%/피로)
  - 부상 위험 2배 증가

💡 휴식 1회로 피로 20 회복 + 자신감 상승''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '훈련',
            icon: Icons.fitness_center,
            content: '''
훈련으로 스탯을 성장시킬 수 있습니다.

[기본 훈련]
• 슈팅: 슈팅 +1~2, 피로 +15
• 패스: 패스 +1~2, 피로 +15
• 드리블: 볼컨트롤 +1~2, 피로 +15
• 위치선정: 위치선정 +1~2, 피로 +15
• 체력: 스태미나 +1~2, 피로 +18
• 멘탈: 침착성 +1~2, 피로 +12
• 휴식: 피로 -20, 자신감 +1
• 재활: 피로 -10, 부상 회복 1주 단축

[훈련 강도]
• 가볍게: 효과 70%, 피로 70%, 부상위험 낮음
• 보통: 기본 효과
• 강하게: 효과 150%, 피로 150%, 부상위험 높음

[훈련 효율]
피로와 자신감에 따라 훈련 효율이 달라집니다.
• 피로 50 이상: 피로 1당 효율 -1% (최대 -30%)
• 자신감: 레벨당 효율 ±5%

⚠️ 피로 70 이상에서 훈련 시 15% 확률로 부상''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '특별 훈련 이벤트',
            icon: Icons.star,
            content: '''
훈련 중 25% 확률로 특별 이벤트가 발생합니다.

📋 코치 특별 지도
- 1:1 맞춤 지도로 훈련 효과 +50%

⚔️ 라이벌과의 경쟁
- 승리 시 자신감 +1
- 패배 시 자신감 -1

🤝 팀 전술 훈련
- 감독 신뢰도 +5

✨ 최고의 컨디션
- 피로 증가 -50%

😓 작은 차질
- 훈련 효과 -30%''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '경기 시스템',
            icon: Icons.stadium,
            content: '''
경기는 하이라이트 장면들로 진행됩니다.

각 장면에서 선택지가 주어지며, 스탯과 상황에 따라 성공 확률이 결정됩니다.

성공 확률에 영향을 주는 요소:
• 관련 스탯 (슈팅, 패스 등)
• 피로도 (높으면 페널티)
• 자신감 (+2%/-2% per level)
• 모멘텀 (연속 성공 시 보너스)
• 상대 팀 레이팅
• 선택한 커맨드 (안전/위험)''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '경기 심화 가이드 (New)',
            icon: Icons.flash_on,
            content: '''
[모멘텀 시스템]
경기 흐름(분위기)을 나타냅니다.
• 🔥 DOMINATING (+3): 모든 성공 확률 대폭 상승
• ❄️ UNDER PRESSURE (-3): 성공 확률 대폭 하락
• 연속 성공 시 모멘텀이 상승하며, 실패 시 하락합니다.

[전술 외침]
경기 중 하단 버튼으로 동료들에게 외칩니다.
• 👏 격려: 모멘텀 소폭 상승 (안전)
• 🤬 질책: 모멘텀 대폭 상승하지만 자신감 하락 위험
• 🧘 진정: 흥분 상태(음수 모멘텀)를 회복

[세트피스 전략]
프리킥/페널티킥 시 다양한 킥을 선택할 수 있습니다.
• 칩슛/파넨카: 골키퍼를 속이는 슛. 리스크가 매우 크지만 성공 시 모멘텀 폭발!
• 무회전 슛: 예측 불가능한 궤적. 랜덤성이 큽니다.
• 감아차기: 안정적인 궤적. 킥 정확도가 중요합니다.

[클러치 타임]
후반 80분 이후, 1점 차 이내의 승부처!
• '강심장(침착성 80↑)' 선수는 능력치가 2배로 발휘됩니다.
• '새가슴' 선수는 평소보다 더 많은 실수를 할 수 있습니다.''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '평점 시스템',
            icon: Icons.star,
            content: '''
경기 중 활약에 따라 평점이 결정됩니다.

• 기본 평점: 6.0
• 골: +8.0
• 어시스트: +5.0
• 일반 성공: +1.5~3.0
• 실패: -2.0~-4.0
• 페널티킥 실축: -8.0

평점은 시즌 개인 순위에 반영됩니다.''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '부상',
            icon: Icons.healing,
            content: '''
부상을 당하면 경기에 출전할 수 없습니다.

부상 발생 조건:
• 훈련 중 (피로 70 이상, 15% 확률)
• 경기 중 특정 상황 (프레싱, 루즈볼 등)

부상 회복:
• 경기 결장 시 자동으로 1주 회복
• 재활 훈련으로 1주 추가 단축 가능
• 부상 중에도 휴식은 가능''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '신뢰도',
            icon: Icons.handshake,
            content: '''
감독의 신뢰도는 출전 기회에 영향을 줍니다.

• 경기 활약 시 상승
• 좋은 평점 유지 시 상승
• 부상/결장 시 하락 가능

💡 높은 신뢰도 = 더 많은 하이라이트 기회''',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: '자신감',
            icon: Icons.emoji_emotions,
            content: '''
자신감은 경기력에 미세한 보너스/페널티를 줍니다.

• 최고 (+3): 성공률 +6%
• 좋음 (+1~2): 성공률 +2~4%
• 보통 (0): 영향 없음
• 낮음 (-1~2): 성공률 -2~4%
• 최저 (-3): 성공률 -6%

골/어시스트, 휴식으로 상승
실패, 부상으로 하락''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Card(
      child: ExpansionTile(
        leading: Icon(icon, color: RetroColors.primary),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        initiallyExpanded: false,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(
            content.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
