# 문서 패키지 안내
- 작성일: 2026-01-19
- 프로젝트: **선수 커리어 기반 MUD 축구 게임 (Flutter/Dart)**

## 이 ZIP에 포함된 문서
1. `GDD.md` : 게임 디자인 문서(비전/루프/콘텐츠/UX 기준)
2. `TDD.md` : 기술 설계 문서(아키텍처/모듈/데이터/상태관리)
3. `DOMAIN_MODEL.md` : 도메인 모델/스키마/직렬화 규약
4. `STATE_MACHINE.md` : 전역/경기 상태 머신, 이벤트 처리 규칙
5. `MATCH_ENGINE.md` : 하이라이트 경기 엔진 상세(입출력, 알고리즘, 확률 모델)
6. `EVENT_CATALOG.md` : HighlightEvent 카탈로그(12종 MVP + 확장 규칙)
7. `BALANCE_RULES.md` : 밸런스/수식/튜닝 포인트/목표 분포
8. `UI_FLOW.md` : 화면/플로우/컴포넌트, UX 규칙(텍스트 로그/선택지)
9. `PERSISTENCE.md` : 저장/불러오기, 마이그레이션, 스냅샷 전략
10. `TEST_PLAN.md` : 테스트 전략(단위/시뮬레이션/회귀/밸런스 검증)
11. `BACKLOG.md` : AI 에이전트 실행용 작업 백로그(에픽/티켓/수용 기준)

## 권장 실행 순서(에이전트)
1) `TDD.md`를 기준으로 프로젝트 스캐폴딩 생성
2) `DOMAIN_MODEL.md` → 모델/직렬화 구현
3) `STATE_MACHINE.md` → 상태 전환/리듀서 구현
4) `MATCH_ENGINE.md` + `EVENT_CATALOG.md` → 엔진/이벤트 구현
5) `PERSISTENCE.md` → 저장/로드
6) `UI_FLOW.md` → 최소 UI 연결
7) `TEST_PLAN.md` → 시뮬레이션 테스트 자동화
