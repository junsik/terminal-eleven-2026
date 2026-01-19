# ADR-003: 다중 엔딩 시스템

## 상태
제안됨

## 컨텍스트

현재 게임은 시즌 종료 후 단순히 끝납니다. 명확한 목표나 결말이 없어 플레이 동기가 약합니다.

### 현재 문제점
1. "왜 플레이하는가?"에 대한 답이 없음
2. 성공/실패의 구분이 모호함
3. 엔딩 달성의 성취감 없음

### 요구사항
- 플레이어가 향해 갈 명확한 목표
- 실패 가능성으로 인한 긴장감
- 다양한 엔딩으로 리플레이 가치

## 결정

### 1. 엔딩 계층 구조

```
                    ┌─────────────┐
                    │  레전드급   │  ← 최고 엔딩
                    │  (3종류)    │
                    └──────┬──────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
        ┌─────┴─────┐ ┌────┴────┐ ┌─────┴─────┐
        │  성공급   │ │ 성공급  │ │  성공급   │  ← 좋은 엔딩
        │  (5종류)  │ │         │ │           │
        └─────┬─────┘ └────┬────┘ └─────┬─────┘
              │            │            │
        ┌─────┴─────┐ ┌────┴────┐ ┌─────┴─────┐
        │  보통급   │ │ 보통급  │ │  보통급   │  ← 무난한 엔딩
        │  (4종류)  │ │         │ │           │
        └─────┬─────┘ └────┬────┘ └─────┴─────┘
              │            │
        ┌─────┴────────────┴─────┐
        │       실패급           │  ← 나쁜 엔딩
        │       (3종류)          │
        └────────────────────────┘
```

### 2. 엔딩 목록

#### 레전드급 (최고)

| ID | 이름 | 조건 | 설명 |
|----|------|------|------|
| `E_LEGEND_01` | 발롱도르 | 빅클럽 + 시즌 20골 + 평점 8.5 | 세계 최고의 선수로 인정받다 |
| `E_LEGEND_02` | 월드컵 영웅 | 국가대표 + 월드컵 결승골 | 국민 영웅이 되다 |
| `E_LEGEND_03` | 원클럽맨 레전드 | 한 팀 10시즌 + 통산 150골 | 팀의 영원한 전설로 남다 |

#### 성공급 (좋음)

| ID | 이름 | 조건 | 설명 |
|----|------|------|------|
| `E_SUCCESS_01` | 빅클럽 스타 | 빅클럽 주전 3시즌 | 세계적인 선수로 성장하다 |
| `E_SUCCESS_02` | 국가대표 에이스 | 국대 50경기 + 20골 | 태극마크의 자부심 |
| `E_SUCCESS_03` | 리그 득점왕 | 득점왕 2회 | 골잡이로서의 명성 |
| `E_SUCCESS_04` | 컵 전문가 | FA컵/리그컵 3회 우승 | 결정적 순간의 사나이 |
| `E_SUCCESS_05` | 해외파 성공기 | 유럽 5시즌 + 평균 평점 7.0 | 한국 축구의 위상을 높이다 |

#### 보통급 (무난)

| ID | 이름 | 조건 | 설명 |
|----|------|------|------|
| `E_NORMAL_01` | K리그 베테랑 | K리그 10시즌 | 묵묵히 자리를 지키다 |
| `E_NORMAL_02` | 팀의 숨은 공신 | 통산 어시스트 50개 | 화려하진 않지만 든든한 |
| `E_NORMAL_03` | 로컬 히어로 | 한 팀 5시즌 + 팬 이벤트 다수 | 지역 팬들의 사랑을 받다 |
| `E_NORMAL_04` | 늦깎이 프로 | 30세 이후 전성기 | 포기하지 않은 자의 보상 |

#### 실패급 (나쁨)

| ID | 이름 | 조건 | 설명 |
|----|------|------|------|
| `E_FAIL_01` | 부상으로 은퇴 | 심각한 부상 3회 | 빛을 보지 못한 재능 |
| `E_FAIL_02` | 방출 | 신뢰도 0 + 이적 실패 | 어디에서도 원하지 않는 |
| `E_FAIL_03` | 잊혀진 선수 | 5시즌 연속 평점 5.5 미만 | 기대에 부응하지 못하다 |

### 3. 데이터 모델

```dart
enum EndingTier { legend, success, normal, failure }

@freezed
class Ending with _$Ending {
  const factory Ending({
    required String id,
    required String name,
    required EndingTier tier,
    required String description,
    required String epilogue,  // 엔딩 스토리 텍스트
    required EndingCondition condition,
    String? unlockImageAsset,
  }) = _Ending;
}

@freezed
class EndingCondition with _$EndingCondition {
  const factory EndingCondition({
    int? minSeasons,
    int? minGoals,
    int? minAssists,
    double? minAvgRating,
    int? minReputation,
    String? requiredLeague,
    List<String>? requiredFlags,
    List<String>? requiredAchievements,
  }) = _EndingCondition;
}
```

### 4. 엔딩 체크 로직

```dart
class EndingEngine {
  Ending? checkEnding(PlayerCareer career, PlayerFlags flags) {
    // 은퇴 조건 체크
    if (!_shouldRetire(career)) return null;

    // 우선순위: 레전드 → 성공 → 보통 → 실패
    for (final ending in _sortedByPriority(allEndings)) {
      if (_meetsCondition(ending, career, flags)) {
        return ending;
      }
    }

    // 기본 엔딩
    return _defaultEnding;
  }

  bool _shouldRetire(PlayerCareer career) {
    return career.age >= 35  // 나이 제한
        || career.severeInjuries >= 3  // 부상 은퇴
        || career.consecutiveUnemployed >= 2;  // 방출
  }
}
```

### 5. 은퇴 시점 결정

```dart
enum RetirementTrigger {
  age,           // 35세 도달
  injury,        // 심각한 부상 누적
  released,      // 팀 방출 후 무소속
  voluntary,     // 플레이어 선택
}
```

**나이 기반 은퇴:**
- 32세: "은퇴를 고려해볼 때입니다" 이벤트
- 33세: 스탯 하락 시작 (-1~2 매 시즌)
- 35세: 강제 은퇴

**부상 기반 은퇴:**
- 심각한 부상 3회 → 은퇴 권고 이벤트
- 거부 시 → 4번째 부상에서 강제 은퇴

### 6. 엔딩 화면 구성

```
┌─────────────────────────────────────────┐
│                                         │
│          ⭐ 커리어 종료 ⭐              │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │     🏆 빅클럽 스타 🏆           │    │
│  │                                 │    │
│  │   "세계적인 선수로 성장하다"    │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────── 에필로그 ───────────       │
│                                         │
│  12년의 프로 생활을 마치며...           │
│  수많은 골과 트로피, 그리고 팬들의      │
│  환호 속에서 당신은 그라운드를          │
│  떠납니다. 하지만 당신의 이름은         │
│  영원히 기억될 것입니다.                │
│                                         │
│  ─────────── 통산 기록 ───────────      │
│                                         │
│  경기: 412  |  골: 156  |  도움: 78     │
│  평균 평점: 7.2                         │
│  트로피: 리그 우승 2회, 컵 우승 1회     │
│                                         │
│  ───────────────────────────────────    │
│                                         │
│       [기록 저장]  [새 게임]            │
│                                         │
└─────────────────────────────────────────┘
```

### 7. 엔딩 해금 시스템

```dart
class EndingUnlockManager {
  Set<String> unlockedEndings = {};

  void unlock(String endingId) {
    unlockedEndings.add(endingId);
    _saveToStorage();
  }

  double getCompletionRate() {
    return unlockedEndings.length / allEndings.length;
  }
}
```

**갤러리 화면:**
```
┌─────────────────────────────────────┐
│         📖 엔딩 갤러리               │
│         (8/15 해금됨)               │
├─────────────────────────────────────┤
│                                     │
│  [레전드급] ★★★                     │
│  ⬜ 발롱도르     ⬜ 월드컵 영웅      │
│  ⬜ 원클럽맨 레전드                  │
│                                     │
│  [성공급] ★★                        │
│  ✅ 빅클럽 스타  ✅ 국가대표 에이스  │
│  ⬜ 리그 득점왕  ✅ 컵 전문가        │
│                                     │
│  [보통급] ★                         │
│  ✅ K리그 베테랑 ✅ 팀의 숨은 공신   │
│  ...                                │
│                                     │
└─────────────────────────────────────┘
```

## 결과

### 긍정적 영향
- 명확한 플레이 목표 제공
- "레전드 엔딩 보고 싶다" → 리플레이 동기
- 실패 가능성 → 긴장감
- 엔딩 수집 → 장기 플레이 유도

### 부정적 영향
- 15개 엔딩 에필로그 텍스트 작성 필요
- 밸런싱: 레전드가 너무 어렵거나 쉬우면 안됨
- 실패 엔딩의 좌절감 관리

### 구현 범위

**Phase 1 (MVP):**
- 5개 엔딩 (레전드 1, 성공 2, 보통 1, 실패 1)
- 기본 엔딩 화면

**Phase 2:**
- 전체 15개 엔딩
- 엔딩 갤러리

**Phase 3:**
- 히든 엔딩 추가
- 엔딩별 특수 보상

## 관련 문서
- [ADR-001: 이적 시스템](./ADR-001-transfer-career-system.md)
- [ADR-002: 스토리 이벤트 시스템](./ADR-002-story-event-system.md)
