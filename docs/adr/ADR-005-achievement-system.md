# ADR-005: 업적 시스템

## 상태
제안됨

## 컨텍스트

현재 게임은 경기/시즌 기록을 저장하지만, 이를 활용한 수집/달성 요소가 없습니다.

### 현재 문제점
1. "이번 경기 해트트릭!" → 기록만 되고 끝
2. 장기 플레이 보상 없음
3. 리플레이 동기 부족

### 요구사항
- 달성 가능한 목표들
- 수집 욕구 자극
- 히든 업적으로 탐험 유도

## 결정

### 1. 업적 카테고리

```
┌────────────────────────────────────────┐
│             업적 카테고리              │
├────────────────────────────────────────┤
│                                        │
│  ⚽ [골] 득점 관련 업적                │
│  🎯 [플레이] 경기 내 특별 플레이       │
│  📈 [성장] 스탯/레벨 성장              │
│  🏆 [커리어] 장기 커리어 달성          │
│  🔮 [히든] 숨겨진 특수 업적            │
│                                        │
└────────────────────────────────────────┘
```

### 2. 데이터 모델

```dart
enum AchievementCategory { goal, play, growth, career, hidden }
enum AchievementRarity { common, uncommon, rare, epic, legendary }

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String name,
    required String description,
    required AchievementCategory category,
    required AchievementRarity rarity,
    required AchievementCondition condition,
    String? hint,  // 히든 업적용 힌트
    int? rewardXP,
    String? rewardTitle,  // 칭호 보상
  }) = _Achievement;
}

@freezed
class AchievementCondition with _$AchievementCondition {
  // 단일 조건
  const factory AchievementCondition.single({
    required String stat,
    required String operator,  // >=, ==, <=
    required int value,
  }) = SingleCondition;

  // 복합 조건
  const factory AchievementCondition.compound({
    required List<AchievementCondition> conditions,
    required String logic,  // AND, OR
  }) = CompoundCondition;

  // 이벤트 기반
  const factory AchievementCondition.event({
    required String eventType,
    required int count,
    String? context,  // "in_one_match", "in_one_season"
  }) = EventCondition;
}
```

### 3. 업적 목록

#### ⚽ 골 업적

| ID | 이름 | 조건 | 레어도 | 보상 |
|----|------|------|--------|------|
| `G_01` | 첫 골 | 통산 1골 | Common | 50 XP |
| `G_02` | 골잡이 | 통산 10골 | Common | 100 XP |
| `G_03` | 에이스 스트라이커 | 통산 50골 | Uncommon | 300 XP |
| `G_04` | 골 머신 | 통산 100골 | Rare | 500 XP, "골잡이" 칭호 |
| `G_05` | 레전드 스트라이커 | 통산 200골 | Epic | 1000 XP, "레전드" 칭호 |
| `G_06` | 해트트릭 | 한 경기 3골 | Uncommon | 200 XP |
| `G_07` | 포커 | 한 경기 4골 | Rare | 400 XP |
| `G_08` | 토네이도 | 한 경기 5골+ | Epic | 800 XP |
| `G_09` | 득점왕 | 시즌 득점왕 | Rare | 500 XP |
| `G_10` | 연속 득점왕 | 2시즌 연속 득점왕 | Epic | 1000 XP |

#### 🎯 플레이 업적

| ID | 이름 | 조건 | 레어도 | 보상 |
|----|------|------|--------|------|
| `P_01` | 완벽한 경기 | 평점 10.0 | Epic | 800 XP |
| `P_02` | 맨 오브 더 매치 | 평점 9.0 이상 10회 | Uncommon | 200 XP |
| `P_03` | 클러치 킹 | 결승골 5회 | Rare | 400 XP |
| `P_04` | 연속 성공 | 한 경기 연속 성공 5회 | Uncommon | 150 XP |
| `P_05` | 무실책 | 한 경기 실수 0 + 골 | Rare | 300 XP |
| `P_06` | 페널티 마스터 | 페널티 킥 5연속 성공 | Uncommon | 200 XP |
| `P_07` | 압박의 왕 | 한 경기 성공적 압박 5회 | Uncommon | 150 XP |
| `P_08` | 공격 포인트 | 한 경기 2골 1도움 | Rare | 350 XP |

#### 📈 성장 업적

| ID | 이름 | 조건 | 레어도 | 보상 |
|----|------|------|--------|------|
| `S_01` | 성장의 시작 | 레벨 5 달성 | Common | 50 XP |
| `S_02` | 중견 선수 | 레벨 15 달성 | Uncommon | 150 XP |
| `S_03` | 베테랑 | 레벨 30 달성 | Rare | 300 XP |
| `S_04` | 마스터 | 레벨 50 달성 | Epic | 600 XP |
| `S_05` | 만랩 | 레벨 99 달성 | Legendary | 2000 XP |
| `S_06` | 스탯 장인 | 아무 스탯 90 도달 | Rare | 400 XP |
| `S_07` | 올라운더 | 모든 스탯 70 이상 | Epic | 800 XP |
| `S_08` | 훈련왕 | 총 훈련 100회 | Uncommon | 200 XP |

#### 🏆 커리어 업적

| ID | 이름 | 조건 | 레어도 | 보상 |
|----|------|------|--------|------|
| `C_01` | 프로 데뷔 | 첫 경기 출전 | Common | 30 XP |
| `C_02` | 주전 확보 | 신뢰도 80 도달 | Uncommon | 150 XP |
| `C_03` | 팀의 얼굴 | 신뢰도 100 달성 | Rare | 300 XP |
| `C_04` | 이적생 | 첫 이적 | Common | 100 XP |
| `C_05` | 세계로 | 유럽 리그 진출 | Uncommon | 250 XP |
| `C_06` | 빅클럽 입성 | 빅클럽 입단 | Rare | 500 XP |
| `C_07` | 장수 선수 | 10시즌 플레이 | Rare | 400 XP |
| `C_08` | 충성파 | 한 팀에서 5시즌 | Uncommon | 200 XP |
| `C_09` | 부상 극복 | 심각한 부상 후 복귀 | Uncommon | 200 XP |
| `C_10` | 불사조 | 방출 위기 후 주전 | Rare | 350 XP |

#### 🔮 히든 업적

| ID | 이름 | 힌트 | 조건 | 레어도 |
|----|------|------|------|--------|
| `H_01` | 복수의 칼날 | "옛 팀을 상대로..." | 이적 후 전 팀 상대 해트트릭 | Epic |
| `H_02` | 기적의 역전 | "불가능은 없다" | 0-3에서 역전승 기여 | Legendary |
| `H_03` | 라이벌 정복 | "경쟁을 넘어서" | 라이벌보다 시즌 10골 이상 | Rare |
| `H_04` | 감독 킬러 | "세 명의 감독" | 3명의 감독 경질 경험 | Rare |
| `H_05` | 마지막 순간 | "90분의 드라마" | 후반 추가시간 결승골 3회 | Epic |
| `H_06` | 언더독 | "작은 팀의 영웅" | 하위권 팀에서 득점왕 | Epic |
| `H_07` | 조용한 살인마 | "아무도 모르게" | 평점 7.0 미만 but 시즌 15골 | Rare |
| `H_08` | 진정한 프로 | "10년의 여정" | 한 번도 방출 없이 10시즌 | Legendary |

### 4. 업적 체크 엔진

```dart
class AchievementEngine {
  final Set<String> unlocked = {};

  List<Achievement> checkAll(PlayerStats stats, GameHistory history) {
    final newUnlocks = <Achievement>[];

    for (final achievement in allAchievements) {
      if (unlocked.contains(achievement.id)) continue;

      if (_meetsCondition(achievement.condition, stats, history)) {
        unlocked.add(achievement.id);
        newUnlocks.add(achievement);
      }
    }

    return newUnlocks;
  }

  bool _meetsCondition(
    AchievementCondition condition,
    PlayerStats stats,
    GameHistory history,
  ) {
    return condition.when(
      single: (stat, op, value) => _checkSingle(stat, op, value, stats),
      compound: (conditions, logic) => _checkCompound(conditions, logic, stats, history),
      event: (type, count, context) => _checkEvent(type, count, context, history),
    );
  }
}
```

### 5. 업적 달성 알림

```dart
class AchievementNotification {
  void show(Achievement achievement) {
    // 팝업 표시
    /*
    ┌─────────────────────────────────┐
    │  🏆 업적 달성!                  │
    │  ═══════════════════════════    │
    │                                 │
    │  ⭐ 해트트릭 ⭐                 │
    │  "한 경기에서 3골을 넣었습니다" │
    │                                 │
    │  +200 XP                        │
    │                                 │
    │         [확인]                  │
    └─────────────────────────────────┘
    */
  }
}
```

### 6. 업적 UI

#### 메인 업적 화면
```
┌─────────────────────────────────────┐
│         🏆 업적 (47/82)             │
├─────────────────────────────────────┤
│                                     │
│  [⚽ 골] 12/15      ████████████░░░ │
│  [🎯 플레이] 8/12   ████████░░░░░░░ │
│  [📈 성장] 10/15    ████████████░░░ │
│  [🏆 커리어] 14/25  ████████░░░░░░░ │
│  [🔮 히든] 3/15     ███░░░░░░░░░░░░ │
│                                     │
│  ─────── 최근 달성 ───────         │
│                                     │
│  ⭐ 에이스 스트라이커 (1일 전)      │
│  ⭐ 주전 확보 (3일 전)              │
│                                     │
└─────────────────────────────────────┘
```

#### 카테고리 상세
```
┌─────────────────────────────────────┐
│         ⚽ 골 업적 (12/15)          │
├─────────────────────────────────────┤
│                                     │
│  ✅ 첫 골               Common      │
│  ✅ 골잡이              Common      │
│  ✅ 에이스 스트라이커   Uncommon    │
│  🔒 골 머신 (78/100)   Rare        │
│  🔒 레전드 스트라이커   Epic        │
│  ✅ 해트트릭           Uncommon    │
│  🔒 포커               Rare        │
│  🔒 토네이도           Epic        │
│  ...                               │
│                                     │
└─────────────────────────────────────┘
```

### 7. 칭호 시스템

달성한 업적에 따라 칭호 해금:

```dart
class TitleSystem {
  String currentTitle = '';
  Set<String> unlockedTitles = {};

  void unlockTitle(String title) {
    unlockedTitles.add(title);
  }

  void equipTitle(String title) {
    if (unlockedTitles.contains(title)) {
      currentTitle = title;
    }
  }
}
```

**사용 가능한 칭호:**
- "신인" (기본)
- "골잡이" (골 100개)
- "철인" (무부상 5시즌)
- "레전드" (골 200개)
- "월드클래스" (빅클럽 3시즌)
- "????" (히든 업적)

### 8. 보상 시스템

```dart
class AchievementReward {
  void grant(Achievement achievement, Player player) {
    // XP 보상
    if (achievement.rewardXP != null) {
      player.xp += achievement.rewardXP!;
    }

    // 칭호 보상
    if (achievement.rewardTitle != null) {
      player.titles.add(achievement.rewardTitle!);
    }
  }
}
```

## 결과

### 긍정적 영향
- "해트트릭 업적 해금해야지" → 목표 의식
- 히든 업적 → 탐험/발견의 재미
- 칭호 수집 → 장기 플레이 동기
- 달성 알림 → 성취감

### 부정적 영향
- 업적 밸런싱 (너무 쉽거나 어려움)
- 히든 업적 조건 노출 위험
- 업적 사냥에 집중 → 게임 본질 훼손 가능

### 구현 범위

**Phase 1 (MVP):**
- 골/성장 카테고리 기본 업적 15개
- 달성 알림
- 기본 UI

**Phase 2:**
- 전체 업적 50개
- 히든 업적 5개
- 칭호 시스템

**Phase 3:**
- 전체 82개 업적
- 고급 히든 업적
- 업적 통계/비교

## 관련 문서
- [ADR-003: 엔딩 시스템](./ADR-003-ending-system.md)
- [GDD.md](../GDD.md)
