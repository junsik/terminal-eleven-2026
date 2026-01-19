# ADR-004: NPC 관계 시스템

## 상태
제안됨

## 컨텍스트

현재 게임에서 플레이어는 혼자입니다. 감독은 신뢰도 수치로만 존재하고, 팀 동료나 라이벌이 없습니다.

### 현재 문제점
1. 캐릭터와의 감정적 연결 없음
2. "이 사람 때문에 더 열심히 해야지" 동기 부재
3. 스토리 이벤트의 깊이 부족

### 요구사항
- 플레이어와 상호작용하는 NPC 캐릭터
- 관계 발전에 따른 게임플레이 영향
- 드라마틱한 갈등/협력 서사

## 결정

### 1. NPC 유형

```
┌──────────────────────────────────────────────┐
│                   NPC 유형                   │
├──────────────────────────────────────────────┤
│                                              │
│  [감독]        경기 출전, 전술 영향          │
│  [에이전트]    이적, 계약, 커리어 조언       │
│  [라이벌]      같은 포지션 경쟁자            │
│  [동료]        팀 케미스트리, 어시스트       │
│  [팬 대표]     평판, 응원, 압박              │
│                                              │
└──────────────────────────────────────────────┘
```

### 2. NPC 데이터 모델

```dart
enum NPCType { manager, agent, rival, teammate, fanRep }

@freezed
class NPC with _$NPC {
  const factory NPC({
    required String id,
    required String name,
    required NPCType type,
    required String description,
    required NPCPersonality personality,
    required Map<String, String> dialogues,  // 상황별 대사
    @Default(50) int relationship,  // 0-100 호감도
  }) = _NPC;
}

@freezed
class NPCPersonality with _$NPCPersonality {
  const factory NPCPersonality({
    required String style,      // "엄격함", "온화함", "냉철함"
    required List<String> likes,     // 좋아하는 행동
    required List<String> dislikes,  // 싫어하는 행동
  }) = _NPCPersonality;
}
```

### 3. 핵심 NPC 상세

#### 3.1 감독 (Manager)

```dart
final managerKim = NPC(
  id: 'manager_kim',
  name: '김성훈 감독',
  type: NPCType.manager,
  description: '실용주의적인 전술가. 결과를 중시한다.',
  personality: NPCPersonality(
    style: '냉철함',
    likes: ['골', '좋은 평점', '훈련 참여'],
    dislikes: ['경기 중 이기적 플레이', '훈련 불참', '미디어 문제'],
  ),
  dialogues: {
    'greeting': '준비됐나?',
    'good_performance': '오늘 잘했다. 계속 이렇게 해라.',
    'bad_performance': '이래서는 안 돼. 다음엔 달라야 한다.',
    'benched': '오늘은 벤치에서 지켜봐라. 기회는 온다.',
    'starting': '네가 필요하다. 보여줘.',
  },
);
```

**감독 성향 시스템:**
```dart
enum ManagerStyle {
  strict,     // 엄격: 실수에 민감, 보상도 큼
  nurturing,  // 육성형: 젊은 선수 선호, 실수 관대
  pragmatic,  // 실용적: 결과만 봄
  tactical,   // 전술가: 지시 따르면 신뢰 상승
}
```

#### 3.2 에이전트 (Agent)

```dart
final agentPark = NPC(
  id: 'agent_park',
  name: '박준영 에이전트',
  type: NPCType.agent,
  description: '야심찬 에이전트. 큰 이적을 성사시키고 싶어한다.',
  personality: NPCPersonality(
    style: '야심적',
    likes: ['좋은 활약', '미디어 노출', '평판 상승'],
    dislikes: ['이적 거절', '낮은 연봉 수락'],
  ),
  dialogues: {
    'transfer_offer': '좋은 제안이 들어왔어. 한번 들어볼래?',
    'career_advice': '지금 리그에서 더 성장할 필요가 있어.',
    'big_move': '드디어 빅클럽에서 연락이 왔어!',
    'rejected_advice': '내 말 안 들을 거면 왜 에이전트를 고용했어?',
  },
);
```

**에이전트 기능:**
- 이적 제안 필터링/추천
- 계약 협상 대행
- 커리어 조언 (가끔 틀림)

#### 3.3 라이벌 (Rival)

```dart
final rivalLee = NPC(
  id: 'rival_lee',
  name: '이태현',
  type: NPCType.rival,
  description: '같은 팀의 유스 출신 스트라이커. 주전 자리를 노린다.',
  personality: NPCPersonality(
    style: '경쟁적',
    likes: ['인정해주는 말', '페어플레이'],
    dislikes: ['무시하는 태도', '언론에서 비교'],
  ),
  dialogues: {
    'first_meet': '선배님, 많이 배우겠습니다. (눈빛은 야망으로 가득)',
    'after_your_goal': '...축하드립니다.',
    'after_his_goal': '이번엔 제가 이겼네요.',
    'friendly': '같이 훈련할래요? 서로 발전할 수 있을 것 같아요.',
    'hostile': '다음 경기, 지켜보세요.',
  },
);
```

**라이벌 시스템:**
```dart
class RivalSystem {
  int rivalGoals = 0;
  int yourGoals = 0;
  RivalRelation relation = RivalRelation.neutral;

  void onRivalScores() {
    rivalGoals++;
    // 라이벌 골 → 플레이어 동기부여 or 압박
    if (relation == RivalRelation.friendly) {
      // "그도 잘하네. 나도 해야지"
      player.confidence += 1;
    } else {
      // "저 녀석한테 질 수 없어"
      player.composure -= 2;
    }
  }
}

enum RivalRelation {
  friendly,   // 선의의 경쟁
  neutral,    // 그냥 경쟁자
  hostile,    // 앙숙
}
```

#### 3.4 팀 동료 (Teammate)

```dart
final teammateChoi = NPC(
  id: 'teammate_choi',
  name: '최민수',
  type: NPCType.teammate,
  description: '팀의 베테랑 미드필더. 어시스트 머신.',
  personality: NPCPersonality(
    style: '든든함',
    likes: ['팀플레이', '겸손한 태도'],
    dislikes: ['이기적 플레이', '동료 비난'],
  ),
  dialogues: {
    'good_chemistry': '네가 뛰어주니까 패스하기 편해.',
    'assist': '골 축하해. 나도 기분 좋다.',
    'bad_chemistry': '...공 좀 빨리 줘.',
  },
);
```

**동료 케미스트리:**
```dart
class TeammateChemistry {
  int level = 50;  // 0-100

  double getAssistBonus() {
    // 케미 높으면 어시스트 확률 증가
    return (level - 50) / 100 * 0.1;  // -5% ~ +5%
  }

  void onTeamplayChoice() => level += 3;
  void onSelfishChoice() => level -= 5;
}
```

### 4. 관계도 시스템

```dart
class RelationshipManager {
  Map<String, int> relationships = {};  // NPC ID → 호감도

  void updateRelation(String npcId, int delta) {
    relationships[npcId] =
      (relationships[npcId] ?? 50) + delta;
    relationships[npcId] =
      relationships[npcId]!.clamp(0, 100);
  }

  RelationLevel getLevel(String npcId) {
    final value = relationships[npcId] ?? 50;
    if (value >= 80) return RelationLevel.excellent;
    if (value >= 60) return RelationLevel.good;
    if (value >= 40) return RelationLevel.neutral;
    if (value >= 20) return RelationLevel.poor;
    return RelationLevel.hostile;
  }
}

enum RelationLevel {
  excellent,  // 80-100: 특별한 이벤트/보너스
  good,       // 60-79: 긍정적 상호작용
  neutral,    // 40-59: 기본
  poor,       // 20-39: 부정적 상호작용
  hostile,    // 0-19: 갈등 이벤트 발생
}
```

### 5. NPC 상호작용 이벤트

```yaml
# 감독 관계 나쁠 때
id: manager_conflict
trigger:
  type: condition
  conditions:
    manager_relation: "< 30"

title: "감독과의 갈등"
description: |
  감독이 당신을 사무실로 불렀습니다.
  "솔직히 말하지. 지금 네 태도가 마음에 안 들어."

choices:
  - text: "죄송합니다. 바꾸겠습니다."
    effects:
      - type: relation
        npc: manager
        delta: +15
      - type: trust
        delta: +5

  - text: "전 제 방식대로 하겠습니다."
    effects:
      - type: relation
        npc: manager
        delta: -10
      - type: flag
        name: manager_conflict_unresolved
        value: true
```

```yaml
# 라이벌 우호 관계
id: rival_friendship
trigger:
  type: condition
  conditions:
    rival_relation: ">= 70"

title: "라이벌과의 화해"
description: |
  이태현이 훈련 후 다가왔습니다.
  "형, 솔직히 처음엔 형 자리 뺏고 싶었어요.
   근데 이제는... 형이랑 같이 뛰고 싶어요."

effects:
  - type: flag
    name: rival_became_friend
    value: true
  - type: stat
    name: composure
    delta: +3
```

### 6. NPC 대화 UI

```
┌─────────────────────────────────────┐
│  💬 김성훈 감독                     │
│  ════════════════════════════       │
│  관계: ████████░░ 좋음 (72)         │
├─────────────────────────────────────┤
│                                     │
│  "오늘 훈련 잘했다.                 │
│   이번 주 경기, 선발로 나가라."     │
│                                     │
│  ─────────────────────────          │
│                                     │
│  > "감사합니다. 기대에 부응하겠습니다."  │
│    "네, 알겠습니다." (담담)         │
│    "당연한 거 아닙니까?" (자신감)   │
│                                     │
└─────────────────────────────────────┘
```

### 7. 게임플레이 영향

| NPC | 관계 좋을 때 | 관계 나쁠 때 |
|-----|-------------|-------------|
| 감독 | 주전 기회↑, 실수 용서 | 벤치, 방출 위험 |
| 에이전트 | 좋은 이적 제안 | 이적 기회↓ |
| 라이벌 | 선의의 경쟁, 스탯↑ | 압박, 컴포저↓ |
| 동료 | 어시스트↑, 패스 정확도↑ | 고립, 패스↓ |
| 팬 대표 | 평판↑, 응원 효과 | 야유, 컴포저↓ |

## 결과

### 긍정적 영향
- NPC와 감정적 연결 → 몰입감
- "감독한테 인정받고 싶다" 동기
- 라이벌 스토리 → 드라마
- 선택의 무게감 증가

### 부정적 영향
- NPC 대사/이벤트 작성량 증가
- 관계 밸런싱 복잡도
- 여러 NPC 동시 관리 부담

### 구현 범위

**Phase 1 (MVP):**
- 감독 NPC만 구현 (기존 신뢰도 → 관계 시스템)
- 기본 대화 5종

**Phase 2:**
- 라이벌 시스템 추가
- 관계 기반 이벤트 10개

**Phase 3:**
- 에이전트, 동료, 팬 대표
- 복잡한 관계 상호작용

## 관련 문서
- [ADR-002: 스토리 이벤트 시스템](./ADR-002-story-event-system.md)
- [ADR-003: 엔딩 시스템](./ADR-003-ending-system.md)
