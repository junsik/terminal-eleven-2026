# ADR 006: Match Experience Overhaul

## Status
Accepted (Phase 1 & 2 Complete)

## Features Implementation Status

| Feature | Status | Notes |
|---------|--------|-------|
| **1. 모멘텀 시스템** | ✅ Complete | `momentum`, `consecutiveSuccess/Failure`, HOT/COLD 상태 |
| **2. 인터랙티브 세트피스** | ✅ Complete | `panenka`, `chipShot`, `powerShot`, `curvedShot` 등 |
| **3. 클러치 타임** | ✅ Complete | 80분 이후 1점차 상황, `composure` 가중치 적용 |
| **4. 전술 외침** | ✅ Complete | `shoutEncourage`, `shoutDemand`, `shoutCalm` + 쿨다운 |
| **5. 케미스트리 & 라이벌리** | ❌ Not Started | Phase 3 예정 |

### Implemented Components

**1. 모멘텀 시스템** (`lib/domain/engine/`)
- `MatchSession.momentum` (-3 ~ +3) - 경기 분위기 수치
- `consecutiveSuccess/Failure` - 연속 성공/실패 추적
- HOT 상태: 3연속 성공 시 +8% 보너스 (`MentalConfig.hotStreakBonus`)
- COLD 상태: 2연속 실패 시 -5% 페널티 (`MentalConfig.coldStreakPenalty`)
- `MomentumBar` UI 위젯 (`lib/presentation/match/widgets/momentum_bar.dart`)
- 점진적 회복/하락 (절반씩 감소) 로직

**2. 세트피스 옵션** (`lib/domain/model/command.dart`)
- `CommandType`: `shoot`, `panenka`, `chipShot`, `powerShot`, `curvedShot`, `knuckleShot`
- 각 옵션별 리스크/리턴 차별화 (`EventProbability.riskMultiplier`)
- `HighlightType.penaltyKick`, `setPieceRebound` 지원

**3. 클러치 타임** (`lib/domain/model/match.dart`)
- `MatchSession.isClutchTime`: minute >= 80 && 점수차 <= 1
- `HighlightType.clutchChance` 생성 (`highlight_generator.dart`)
- `composure` 스탯 가중치 증가 (`resolver.dart`)

**4. 전술 외침** (`lib/domain/engine/match_engine.dart`)
- `CommandType.shoutEncourage/Demand/Calm`
- `MatchEngine.processTacticalShout()` - 모멘텀 조절
- `lastShoutIndex` - 하이라이트당 1회 제한 (쿨다운)
- `TacticalControls` UI 위젯 (`lib/presentation/match/widgets/tactical_controls.dart`)

### Key Files Modified
- `lib/domain/model/match.dart` - MatchSession 필드 추가
- `lib/domain/engine/resolver.dart` - 확률 계산 로직
- `lib/domain/engine/match_engine.dart` - 외침 처리
- `lib/domain/config/balance_config.dart` - 밸런스 상수
- `lib/presentation/match/widgets/` - UI 컴포넌트

---

## Context
현재 텍스트 기반 축구 게임의 경기 엔진은 확률 기반의 "주사위 굴리기" 방식에 의존하고 있습니다.
기존 시스템(`MatchEngine` v1)은 다음 한계를 가집니다:
1.  **반복적인 경험**: 매 경기 비슷한 하이라이트와 선택지가 반복되어 플레이어가 쉽게 지루함을 느낍니다.
2.  **전술적 깊이 부재**: 플레이어는 주어진 상황에 반응하기만 할 뿐, 경기의 흐름(Flow)을 주도하거나 전술적으로 개입할 수단이 부족합니다.
3.  **드라마틱한 연출 부족**: 막판 뒤집기나 "클러치 타임"과 같은 극적인 상황에 대한 시스템적 지원이 없습니다.

사용자는 "게임 경기에 대한 아이디어"를 요청했고, 이에 대한 구체적인 개선안(모멘텀, 세트피스 심리전 등)이 제안 및 수락되었습니다.

## Decision
우리는 **Match Experience Overhaul**을 통해 경기 엔진에 다음 5가지 핵심 시스템을 도입하기로 결정했습니다.

### 1. 모멘텀 시스템 (The Flow)
-   **개념**: 경기의 "분위기"를 수치화하여 시각적으로 표시하고 확률에 반영합니다.
-   **구현**: `MatchSession`에 `momentum` 필드를 활성화하고, 좋은 플레이(유효슈팅 등) 시 상승, 실책 시 하락하게 합니다.
-   **효과**: 모멘텀이 높으면 '쉬운 찬스' 빈도 증가 및 성공 보너스 부여.

### 2. 인터랙티브 세트피스 (Set-Piece Mini Games)
-   **개념**: 프리킥/페널티킥 상황에서 단순 킥이 아닌 구질/방향 선택 심리전을 도입합니다.
-   **구현**: `CommandType`을 확장하여 `panenka`, `chipShot` 등의 구체적 옵션을 제공하고, 리스크/리턴을 차별화합니다.

### 3. 클러치 타임 (Clutch Time)
-   **개념**: 경기 80분 이후 1점 차 이내 상황을 "클러치 타임"으로 정의합니다.
-   **효과**: `composure`(침착성) 스탯의 가중치를 2배로 증가시켜, 강심장 선수의 가치를 극대화합니다.

### 4. 전술 외침 (Tactical Shouts)
-   **개념**: 오프 더 볼 상황(하이라이트 사이)에서 동료에게 버프/디버프를 주는 커맨드를 실행합니다.
-   **구현**: `GameAction`의 일종으로 구현하며, 쿨타임 또는 횟수 제한을 둡니다.

### 5. 케미스트리 & 라이벌리
-   **개념**: 특정 선수 간의 상호작용에 따른 스탯 보너스를 부여합니다. (초기 단계에서는 간단한 패스 성공률 보정으로 시작)

## Consequences
### Positive
-   **몰입감 증대**: 단순히 텍스트를 읽는 것이 아니라, "흐름을 탄다"는 느낌을 줄 수 있습니다.
-   **선택의 의미 강화**: "파넨카 킥" 같은 고위험 선택지를 통해 플레이어의 성향을 반영할 수 있습니다.
-   **스탯 가치 재발견**: 그동안 중요도가 낮았던 `composure`나 `leadership` 스탯이 중요해집니다.

### Negative
-   **복잡도 증가**: `MatchEngine`과 `HighlightResolver`의 로직이 복잡해져, 버그 발생 가능성이 높아집니다.
-   **밸런싱 난이도 상승**: 모멘텀 스노우볼이 너무 강하면, 한 번 밀린 경기를 뒤집기 불가능해질 수 있습니다. (역전 보정 로직 필요)
-   **UI 복잡도**: 모멘텀 바, 다양한 선택지 버튼 등으로 인해 UI가 산만해질 수 있습니다.

## Implementation Strategy
안전한 도입을 위해 다음 단계로 나누어 배포합니다.
1.  **Phase 1**: 모멘텀 시스템 & 인터랙티브 세트피스 (기반 마련)
2.  **Phase 2**: 전술 외침 & 클러치 타임 (심화)
3.  **Phase 3**: 케미스트리 & 라이벌리 (확장)
