# ADR-002: 스토리 이벤트 시스템

## 상태
제안됨

## 컨텍스트

현재 게임은 훈련 → 경기 → 결과의 반복입니다. 예측 불가능한 드라마틱 이벤트가 없어 몰입감이 떨어집니다.

### 현재 문제점
1. 모든 주차가 동일한 패턴
2. "다음에 무슨 일이 일어날까?" 궁금증 없음
3. 텍스트 게임의 핵심인 서사가 약함

### 요구사항
- 예측 불가능한 이벤트로 긴장감 유지
- 플레이어 선택이 장기적 영향을 미침
- 캐릭터와 감정적 연결

## 결정

### 1. 이벤트 카테고리

```
[커리어 이벤트]     - 이적, 계약, 국가대표
[팀 이벤트]         - 감독 교체, 팀 위기, 더비 매치
[개인 이벤트]       - 부상, 슬럼프, 컨디션
[미디어 이벤트]     - 인터뷰, 루머, SNS
[관계 이벤트]       - 동료, 라이벌, 팬
```

### 2. 이벤트 데이터 구조

```dart
@freezed
class StoryEvent with _$StoryEvent {
  const factory StoryEvent({
    required String id,
    required EventCategory category,
    required String title,
    required String description,
    required List<EventChoice> choices,
    required EventTrigger trigger,
    @Default(false) bool isOneTime,  // 1회성 이벤트 여부
  }) = _StoryEvent;
}

@freezed
class EventChoice with _$EventChoice {
  const factory EventChoice({
    required String text,
    required String resultDescription,
    required List<EventEffect> effects,
    Map<String, int>? requirements,  // 선택 조건
  }) = _EventChoice;
}

@freezed
class EventEffect with _$EventEffect {
  const factory EventEffect.stat({
    required String statName,
    required int delta,
  }) = StatEffect;

  const factory EventEffect.trust({
    required int delta,
  }) = TrustEffect;

  const factory EventEffect.reputation({
    required int delta,
  }) = ReputationEffect;

  const factory EventEffect.flag({
    required String flagName,
    required bool value,
  }) = FlagEffect;

  const factory EventEffect.delayed({
    required String eventId,
    required int delayRounds,
  }) = DelayedEffect;
}
```

### 3. 이벤트 트리거 시스템

```dart
@freezed
class EventTrigger with _$EventTrigger {
  // 확률 기반
  const factory EventTrigger.random({
    required double probability,
    int? minRound,
    int? maxRound,
  }) = RandomTrigger;

  // 조건 기반
  const factory EventTrigger.condition({
    required Map<String, dynamic> conditions,
  }) = ConditionTrigger;

  // 시점 기반
  const factory EventTrigger.scheduled({
    required int round,
  }) = ScheduledTrigger;

  // 이전 이벤트 연계
  const factory EventTrigger.chained({
    required String previousEventId,
    required String choiceId,
  }) = ChainedTrigger;
}
```

### 4. 주요 이벤트 시나리오

#### 4.1 미디어 인터뷰 이벤트

```yaml
id: media_interview_basic
category: media
trigger:
  type: condition
  conditions:
    goals_this_season: ">= 5"

title: "기자 인터뷰 요청"
description: |
  지역 스포츠 신문에서 인터뷰를 요청했습니다.
  "최근 좋은 활약을 펼치고 계신데, 비결이 뭔가요?"

choices:
  - text: "팀 동료들 덕분입니다" (겸손)
    effects:
      - type: trust
        delta: +3
      - type: reputation
        delta: +2
      - type: flag
        name: humble_image
        value: true

  - text: "열심히 훈련한 결과입니다" (자신감)
    effects:
      - type: reputation
        delta: +5
      - type: flag
        name: confident_image
        value: true

  - text: "아직 부족합니다" (회피)
    effects:
      - type: trust
        delta: +1
```

#### 4.2 라이벌 등장 이벤트

```yaml
id: rival_appears
category: relationship
trigger:
  type: scheduled
  round: 5  # 시즌 초반

title: "새로운 경쟁자"
description: |
  팀에 새로운 공격수가 영입되었습니다.
  유스 출신의 유망주 '김태현'입니다.

  감독: "건전한 경쟁을 기대합니다."

choices:
  - text: "환영한다, 같이 열심히 하자"
    effects:
      - type: flag
        name: rival_friendly
        value: true
      - type: trust
        delta: +2

  - text: "내 자리는 내가 지킨다" (내심)
    effects:
      - type: stat
        name: composure
        delta: +2
      - type: flag
        name: rival_competitive
        value: true

# 연계 이벤트: 라이벌이 골을 넣으면 발생
id: rival_scores
trigger:
  type: chained
  previous: rival_appears
  condition: rival_goal_count >= 1

description: |
  김태현이 오늘 경기에서 멋진 골을 넣었습니다.
  기자들의 관심이 그에게 쏠리고 있습니다.

  당신의 기분은...
```

#### 4.3 부상 중 출전 결정

```yaml
id: play_through_injury
category: personal
trigger:
  type: condition
  conditions:
    injury_status: minor
    important_match: true

title: "중요한 경기, 부상 중"
description: |
  컵 결승전이 다가왔지만, 아직 부상이 완치되지 않았습니다.
  의료진: "무리하면 악화될 수 있습니다."
  감독: "네 결정을 존중하겠다."

choices:
  - text: "출전하겠습니다"
    effects:
      - type: trust
        delta: +10
      - type: flag
        name: played_injured
        value: true
      - type: delayed
        event: injury_worsens
        probability: 0.4
        delay: 2

  - text: "컨디션 회복이 우선입니다"
    effects:
      - type: trust
        delta: -5
      - type: stat
        name: stamina
        delta: +3
```

#### 4.4 감독 교체 이벤트

```yaml
id: manager_change
category: team
trigger:
  type: condition
  conditions:
    team_standing: ">= 8"  # 하위권
    round: ">= 10"

title: "감독 경질"
description: |
  성적 부진으로 감독이 경질되었습니다.
  새 감독 '박철수'가 부임합니다.

  "모든 선수에게 새로운 기회를 주겠습니다."

effects:
  - type: trust
    delta: -20  # 신뢰도 리셋
  - type: flag
    name: new_manager
    value: true

# 후속 이벤트
id: new_manager_meeting
trigger:
  type: chained
  previous: manager_change

title: "새 감독과의 면담"
description: |
  새 감독이 개인 면담을 요청했습니다.
  "자네에 대해 들었네. 직접 보여줄 준비가 됐나?"

choices:
  - text: "믿어주시면 보답하겠습니다"
    effects:
      - type: trust
        delta: +10

  - text: "전 감독님과 잘 맞지 않았을 뿐입니다"
    effects:
      - type: trust
        delta: -5
      - type: flag
        name: complained_about_manager
        value: true
```

### 5. 이벤트 발생 엔진

```dart
class StoryEventEngine {
  List<StoryEvent> checkTriggers(GameState state) {
    final triggered = <StoryEvent>[];

    for (final event in allEvents) {
      if (_shouldTrigger(event, state)) {
        triggered.add(event);
      }
    }

    // 한 라운드에 최대 1-2개 이벤트
    return _prioritize(triggered).take(2).toList();
  }

  bool _shouldTrigger(StoryEvent event, GameState state) {
    // 1회성 이벤트 체크
    if (event.isOneTime && state.completedEvents.contains(event.id)) {
      return false;
    }

    return event.trigger.when(
      random: (t) => _checkRandom(t, state),
      condition: (t) => _checkCondition(t, state),
      scheduled: (t) => state.currentRound == t.round,
      chained: (t) => _checkChain(t, state),
    );
  }
}
```

### 6. 플래그 시스템

장기적 결과를 위한 플래그 관리:

```dart
class PlayerFlags {
  // 성격/이미지 플래그
  bool humbleImage = false;
  bool confidentImage = false;
  bool troublemaker = false;

  // 관계 플래그
  bool rivalFriendly = false;
  bool rivalCompetitive = false;
  bool managerConflict = false;

  // 히스토리 플래그
  bool playedInjured = false;
  bool rejectedTransfer = false;
  bool wonCup = false;
}
```

### 7. UI 표현

```
┌─────────────────────────────────────┐
│  📰 이벤트                          │
├─────────────────────────────────────┤
│                                     │
│  [미디어] 기자 인터뷰 요청          │
│  ─────────────────────────          │
│                                     │
│  "최근 활약의 비결이 뭔가요?"       │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ > 팀 동료들 덕분입니다      │    │
│  │   열심히 훈련한 결과입니다  │    │
│  │   아직 부족합니다           │    │
│  └─────────────────────────────┘    │
│                                     │
└─────────────────────────────────────┘
```

## 결과

### 긍정적 영향
- "다음엔 무슨 일이?" 궁금증 유발
- 선택의 장기적 영향으로 몰입감 증가
- 플레이어마다 다른 스토리 경험
- 리플레이 가치 대폭 상승

### 부정적 영향
- 이벤트 콘텐츠 작성 필요 (노동 집약적)
- 플래그 관리 복잡도
- 밸런싱 어려움

### 구현 범위

**Phase 1 (MVP):**
- 핵심 이벤트 10개
- 미디어 인터뷰, 부상 결정, 감독 면담

**Phase 2:**
- 라이벌 시스템
- 연계 이벤트 체인

**Phase 3:**
- 50개 이상 이벤트
- 복잡한 플래그 상호작용

## 관련 문서
- [ADR-001: 이적 시스템](./ADR-001-transfer-career-system.md)
- [ADR-004: NPC 관계 시스템](./ADR-004-npc-relationship-system.md)
