# EVENT_CATALOG.md — 하이라이트 이벤트 카탈로그(MVP 12종)

## 공통 필드
- zone: {DEF, MID, ATT, BOX}
- pressure: 0..3 (낮음~매우 높음)
- scoreContext: {LEADING, DRAW, TRAILING}
- minute: 1..90+
- choices: 2~4개

각 이벤트는 다음을 정의한다:
- 상황 설명 템플릿(2~5개)
- 선택지 목록
- 선택지별 결과 분기(성공/실패/파울/득점 등)
- 관련 스탯/가중치

---

## 1) RUN_IN_BEHIND (뒷공간 침투)
### 상황
수비 라인 뒤 공간이 보인다. 타이밍이 핵심.
### 선택지
- CALL_FOR_BALL: 침투 요청
- SAFE_PLAY: 내려와서 연계
- DRIBBLE: 공을 받으면 바로 몰고 들어감(성공 시 큰 찬스)
### 주요 스탯
- pace(0.5), positioning(0.3), composure(0.2)
### 성공 시 결과
- 1:1 혹은 컷백 찬스 생성(ONE_ON_ONE 또는 PASS_CHANCE로 연결)
### 실패 시 결과
- 오프사이드/차단 → 평점 -1, 자신감 -1(선택)

---

## 2) RECEIVE_AND_TURN (등지고 받아 턴)
### 선택지
- DRIBBLE: 턴 후 전진
- PASS: 원터치 패스
- SAFE_PLAY: 뒤로 리턴
### 스탯
- ballControl(0.5), composure(0.3), passing(0.2)

---

## 3) ONE_ON_ONE (키퍼와 1:1)
### 선택지
- SHOOT: 빠른 슛(낮은 각도)
- DRIBBLE: 제치고 마무리(리스크↑)
- PASS: 옆 동료에게 내줌(어시스트 가능)
### 스탯
- shooting(0.5), composure(0.3), ballControl(0.2)

---

## 4) EDGE_OF_BOX_SHOT (박스 앞 중거리)
### 선택지
- SHOOT
- PASS
- SAFE_PLAY
### 스탯
- shooting(0.6), composure(0.2), passing(0.2)

---

## 5) QUICK_COUNTER (역습 전개)
### 선택지
- DRIBBLE: 캐리
- PASS: 스루패스
- SAFE_PLAY: 템포 조절
### 스탯
- pace(0.3), passing(0.4), ballControl(0.3)

---

## 6) PRESSING (전방 압박)
### 선택지
- PRESS: 강압
- CONTAIN: 각도 차단
- TACKLE: 과감 태클(카드/부상 위험)
### 스탯
- stamina(0.3), pace(0.2), composure(0.2), positioning(0.3)

---

## 7) DEFENSIVE_COVER (수비 커버)
### 선택지
- FALL_BACK
- CONTAIN
### 스탯
- positioning(0.6), stamina(0.4)

---

## 8) LOOSE_BALL (세컨볼 경합)
### 선택지
- TACKLE: 몸싸움
- DRIBBLE: 먼저 치고 나감
- SAFE_PLAY
### 스탯
- ballControl(0.3), stamina(0.3), pace(0.2), composure(0.2)

---

## 9) SET_PIECE_REBOUND (세트피스 세컨 찬스)
### 선택지
- SHOOT
- PASS
- SAFE_PLAY
### 스탯
- shooting(0.5), positioning(0.3), composure(0.2)

---

## 10) FATIGUE_MOMENT (피로 구간)
### 상황
숨이 차고 판단이 느려진다.
### 선택지
- SAFE_PLAY: 안정적으로
- FORCE_PLAY: 무리해서 찬스 시도(실수 위험)
### 스탯
- stamina(0.5), composure(0.5)

---

## 11) MENTAL_PRESSURE (멘탈 압박)
### 상황
실수 직후, 관중의 야유/코치의 시선
### 선택지
- COMPOSE: 루틴 회복
- CALL_FOR_BALL: 다시 받는다
- SAFE_PLAY
### 스탯
- composure(0.7), positioning(0.3)

---

## 12) COACH_FEEDBACK_EVENT (코치 피드백)
### 상황
하프타임/경기 후 코치가 지시
### 선택지
- ACCEPT: 지시 수용(신뢰↑)
- ASK_ROLE: 역할 질문(정보↑)
- IGNORE: 무시(신뢰↓)
### 효과
- 직접 성공/실패가 아니라 신뢰/관여도에 영향
