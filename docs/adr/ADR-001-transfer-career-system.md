# ADR-001: 이적 및 커리어 진행 시스템

## 상태
제안됨

## 컨텍스트

현재 게임은 K리그 단일 시즌만 진행됩니다. 플레이어에게 장기적인 목표와 성장의 보람이 부족합니다.

### 현재 문제점
1. K리그 1개 시즌 후 게임 종료 → 목표 부재
2. 성장해도 갈 곳이 없음 → 동기 부여 약함
3. 리플레이 가치 낮음

### 요구사항
- 플레이어가 "더 높은 곳"을 향해 노력하는 느낌
- 이적 결정의 긴장감
- 최소 5년 이상의 커리어 플레이 가능

## 결정

### 1. 리그 계층 구조

```
Tier 1: K리그2 (시작점, 쉬움)
Tier 2: K리그1 (중간)
Tier 3: 유럽 중위권 리그 (에레디비지, 포르투갈 등)
Tier 4: 유럽 5대 리그 하위권
Tier 5: 유럽 5대 리그 빅클럽
```

### 2. 리그별 특성

| 리그 | 팀 수 | 경기 수 | 난이도 배율 | 특징 |
|-----|------|--------|-----------|------|
| K리그2 | 10 | 18 | 0.8x | 입문용, 관대한 감독 |
| K리그1 | 10 | 18 | 1.0x | 기준점 |
| 유럽 중위권 | 8 | 14 | 1.2x | 언어/문화 적응 이벤트 |
| 유럽 상위권 | 8 | 14 | 1.4x | 경쟁 치열, 미디어 관심 |
| 빅클럽 | 6 | 10 | 1.6x | 최고 난이도, 월드클래스 경쟁 |

### 3. 이적 트리거 조건

```dart
class TransferOffer {
  final League targetLeague;
  final Team targetTeam;
  final int offerAmount;  // 연봉 (표시용)
  final int deadline;     // 결정 기한 (라운드)
}
```

**이적 제안 발생 조건:**
- 시즌 종료 시 평균 평점 7.0 이상
- 또는 골 10개 이상
- 또는 평판 50 이상

**상위 리그 이적 조건:**
- 현재 리그에서 2시즌 이상 활동
- 평균 평점 7.5 이상
- 팀 신뢰도 70 이상

### 4. 이적 결정 흐름

```
시즌 종료
    ↓
[이적 제안 평가] ← 평점, 골, 평판 기반
    ↓
제안 있음 → [이적 제안 화면]
    ↓
선택: 수락 / 거절 / 협상
    ↓
수락 시 → 새 팀/리그로 이동
거절 시 → 현 팀 잔류 (신뢰도 +5)
```

### 5. 데이터 모델 확장

```dart
// league.dart (신규)
@freezed
class League with _$League {
  const factory League({
    required String id,
    required String name,
    required int tier,
    required double difficultyMultiplier,
    required List<Team> teams,
    required int matchesPerSeason,
  }) = _League;
}

// player.dart 확장
@freezed
class PlayerCareer with _$PlayerCareer {
  const factory PlayerCareer({
    // 기존 필드...
    required int currentSeason,      // 현재 시즌 번호
    required String currentLeagueId, // 현재 리그
    required List<SeasonRecord> history, // 시즌별 기록
  }) = _PlayerCareer;
}

@freezed
class SeasonRecord with _$SeasonRecord {
  const factory SeasonRecord({
    required int season,
    required String leagueId,
    required String teamId,
    required int matches,
    required int goals,
    required int assists,
    required double avgRating,
  }) = _SeasonRecord;
}
```

### 6. 이적 시장 UI

```
┌─────────────────────────────────────┐
│         📬 이적 제안 도착           │
├─────────────────────────────────────┤
│                                     │
│  FC 포르투 (포르투갈 리가)          │
│  ─────────────────────────          │
│  연봉: 주급 €15,000                 │
│  계약: 3년                          │
│  역할: 주전 경쟁                    │
│                                     │
│  "빠른 공격수를 찾고 있습니다.      │
│   당신의 활약을 지켜봤습니다."      │
│                                     │
├─────────────────────────────────────┤
│  [수락]  [거절]  [더 생각해볼게요]  │
└─────────────────────────────────────┘
```

## 결과

### 긍정적 영향
- 장기 플레이 목표 부여 (빅클럽 입성)
- 이적 결정의 드라마틱한 순간
- 리플레이 가치 상승 (다른 경로 선택)
- 난이도 자연스러운 상승 곡선

### 부정적 영향
- 구현 복잡도 증가
- 리그별 팀/데이터 추가 필요
- 밸런싱 난이도 상승

### 구현 범위

**Phase 1 (MVP):**
- K리그2 → K리그1 이적만 구현
- 시즌 종료 시 단순 이적 제안

**Phase 2:**
- 유럽 리그 추가
- 이적 협상 시스템

**Phase 3:**
- 역이적 (하위 리그로)
- 임대 시스템

## 관련 문서
- [GDD.md](../GDD.md)
- [ADR-002: 스토리 이벤트 시스템](./ADR-002-story-event-system.md)
