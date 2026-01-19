# PERSISTENCE.md — 저장/불러오기 및 마이그레이션

## 1. 저장 전략(MVP 권장)
- Hive에 `GameSnapshot` 전체를 저장(단일 키)
- 자동 저장 시점:
  - 훈련 적용 후
  - 경기 종료 후(POST_MATCH)
  - 홈으로 복귀 시

## 2. 스냅샷 포맷
- JSON 루트:
  - version: int
  - savedAt: ISO8601
  - payload: { pc, season, gameState, activeMatch? }

## 3. 마이그레이션
- version 증가 시 `migrate(snapshot)` 수행
- 제거된 필드: 기본값 대입
- 추가된 필드: 기본값/파생값 계산

## 4. 백업/복구
- 저장 시 2단계:
  1) `snapshot.tmp` 저장 성공
  2) `snapshot` 교체(atomic)
- 실패 시 기존 snapshot 유지

## 5. Drift(SQLite) (선택)
- 경기/시즌 통계(조회/랭킹/그래프)를 위해 정규화 저장
- MVP는 Hive만으로 충분, 통계가 커질 때 도입
