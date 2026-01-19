# STATE_MACHINE.md — 상태 머신 및 이벤트 처리

## 1. 전역 게임 상태(GameState)
```text
BOOT
 → HOME
 → TRAINING
 → PRE_MATCH
 → MATCH
 → POST_MATCH
 → HOME (다음 라운드)
```
- BOOT: 로드/세이브 선택, 스냅샷 복원
- HOME: 다음 경기, 상태(피로/신뢰), 인박스 알림
- TRAINING: 훈련/휴식 선택 적용
- PRE_MATCH: 선발/교체 확률 결정, 경기 컨텍스트 생성
- MATCH: 하이라이트 루프(사용자 입력)
- POST_MATCH: 결과 반영, 경험치/부상/신뢰 업데이트

## 2. 경기 상태(MatchPhase)
```text
INTRO
 → HIGHLIGHT_PRESENT
 → HIGHLIGHT_RESOLVE
 → HIGHLIGHT_RESULT
 → FULL_TIME
 → SUMMARY
```
- PRESENT: 상황+선택지 표시
- RESOLVE: 엔진이 확률 계산 및 결과 산출
- RESULT: 중계/결과 로그 출력, 누적치 반영

## 3. 이벤트 처리 규칙
- UI 입력은 오직 `GameController.dispatch(Command)`로 전달
- Controller는 현재 GameState/MatchPhase를 보고 유효성 검증 후 처리
- 유효하지 않은 커맨드는 시스템 로그로 안내하고 무시

## 4. 중단/재개 규칙
- 경기 중 앱 중단: 다음 중 1개 선택
  1) 안전: “하이라이트 종료 후 자동 저장”(권장)
  2) 고급: 현재 MatchSession 스냅샷 저장(추후)
- MVP는 (1) 채택: RESOLVE/RESULT 중간 저장은 금지

## 5. 시드 기반 재현
- MatchSession.rngSeed 고정 시 동일 선택 입력이면 동일 결과 재현 가능
- 버그 리포트: seed + 커맨드 시퀀스를 저장/공유 가능
