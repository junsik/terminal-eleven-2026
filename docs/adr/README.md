# Architecture Decision Records (ADR)

이 폴더는 MUD Soccer Player 게임의 주요 아키텍처 결정 사항을 기록합니다.

## ADR 목록

| 번호 | 제목 | 상태 | 우선순위 |
|-----|------|------|---------|
| [ADR-000](./ADR-000-game-engine-architecture.md) | 게임 엔진 아키텍처 | 제안됨 | 🔴 최우선 |
| [ADR-001](./ADR-001-transfer-career-system.md) | 이적 및 커리어 진행 시스템 | 제안됨 | 🟠 높음 |
| [ADR-002](./ADR-002-story-event-system.md) | 스토리 이벤트 시스템 | 제안됨 | 🟠 높음 |
| [ADR-003](./ADR-003-ending-system.md) | 다중 엔딩 시스템 | 제안됨 | 🟡 중간 |
| [ADR-004](./ADR-004-npc-relationship-system.md) | NPC 관계 시스템 | 제안됨 | 🟡 중간 |
| [ADR-005](./ADR-005-achievement-system.md) | 업적 시스템 | 제안됨 | 🟢 낮음 |

## ADR 상태 정의

- **제안됨**: 검토 및 논의 중
- **승인됨**: 구현 예정
- **구현됨**: 코드에 반영 완료
- **폐기됨**: 더 이상 유효하지 않음

## 구현 순서

```
ADR-000 (엔진 아키텍처) ──────────────────────────────┐
    │                                                 │
    │  기반 아키텍처 완성 후                          │
    │                                                 │
    ▼                                                 │
ADR-001 (이적) ──→ ADR-002 (스토리) ──→ ADR-003 (엔딩)│
    │                   │                             │
    │                   │                             │
    └───────────────────┴──→ ADR-004 (NPC)            │
                                │                     │
                                └──→ ADR-005 (업적) ──┘
```

## 핵심 원칙

**ADR-000에서 정의:**
- **Single Source of Truth**: 모든 데이터는 하나의 원천에서만 관리
- **관심분리**: 데이터 / 렌더링 / 시뮬레이션 / 업데이트 분리
- **순수 함수**: 엔진은 `(State, Action) → State'` 형태
