# Comprehensive Technical Roadmap: "Project Mud Soccer"

이 문서는 프로젝트의 현재 기술적 부채를 해결하고, 확장 가능한 아키텍처로 나아가기 위한 통합 개선 계획안입니다. 이전의 **비판적 코드 리뷰**와 **세이브 시스템 제안**을 하나로 통합했습니다.

---

## 🏗️ 1. 아키텍처 정상화 (Architectural Integrity)

### 현황: "Split Brain" (이중 뇌) 문제
-   현재 `GameController` (레거시, 활성)와 `GameOrchestrator` (신규, 비활성)가 공존하고 있습니다. 로직이 파편화될 위험이 매우 큽니다.

### ✅ 실행 계획 (Action Plan)
1.  **Orchestrator 전환 선언**: 향후 모든 신규 기능(예: 이적 시장, 전직)은 `GameOrchestrator`와 하위 엔진(`CareerEngine` 등)에만 구현합니다.
2.  **MatchEngine 분리**: 현재 `GameController`에 붙어 있는 경기 진행 로직(`processHighlightChoice`)을 순수 함수형 `MatchEngine`으로 추출하여 Orchestrator에 연결합니다.
3.  **UI 바인딩 교체**: `match_screen.dart` 등이 `GameController` 대신 `GameOrchestrator`를 통해 상태를 구독하도록 점진적으로 리팩토링합니다.

---

## 💾 2. 데이터 안정성 및 마이그레이션 (Data Stability)

### 현황: 데이터 유실 및 호환성 위험
-   단일 JSON 덤프 방식이라 쓰기 중 전원이 꺼지면 데이터가 날아갑니다.
-   필드가 추가되면 구버전 세이브가 로드되지 않는(Crash) 문제가 있습니다.

### ✅ 실행 계획 (Action Plan)
1.  **Raw JSON Migration (마이그레이션 매니저 도입)**
    -   `GameSnapshot.fromJson` 호출 **직전**에 개입하는 중간 계층을 만듭니다.
    -   버전별 패치 함수를 실행하여, 구버전 JSON 데이터를 최신 스키마에 맞게 수선(Repair)한 뒤 로딩합니다.
    -   *예: "v1 파일이네? `defending` 필드가 없으니 기본값 50을 넣어주자."*

2.  **Safe Transactional Write (안전 저장)**
    -   `임시 파일 저장` -> `무결성 검증` -> `원본 교체`의 3단계 프로세스를 도입합니다.
    -   가장 최악의 상황(저장 중 배터리 방전)에서도 원본 파일은 유지되도록 보장합니다.

---

## ⚖️ 3. 게임 밸런스 및 유지보수 (Config & Logic)

### 현황: 매직 넘버와 하드코딩
-   `resolver.dart`에 `0.7`, `0.02` 같은 밸런스 계수가 하드코딩되어 있습니다.
-   "거친 태클로..." 같은 한글 텍스트가 로직 안에 박혀 있습니다.

### ✅ 실행 계획 (Action Plan)
1.  **Balance Config 추출**: 모든 계수를 `GameBalanceConfig` 클래스나 JSON 파일로 분리하여, 코드 수정 없이 밸런스를 튜닝할 수 있게 만듭니다.
2.  **i18n 분리**: 엔진은 `MessageKey.roughTackle` 같은 Enum만 반환하고, UI 계층에서 이를 텍스트("거친 태클...")로 변환하도록 분리합니다.

---

## 🚀 4. 성능 및 확장성 (Scalability)

### 현황: 선형 검색 (O(N))
-   `LeagueSimulator`가 팀별 선수를 찾기 위해 리스트를 반복해서 순회합니다. 팀 개수가 늘어나면 렉이 발생할 수 있습니다.

### ✅ 실행 계획 (Action Plan)
1.  **인덱싱 도입**: `Map<TeamId, List<Player>>` 형태의 캐시를 사용하여 조회 성능을 O(1)로 최적화합니다.
2.  **상태 쪼개기**: 거대한 `GameSnapshot` 하나를 구독하는 대신, `SeasonState`, `MatchState` 등으로 Riverpod Provider를 세분화하여 불필요한 리빌드를 방지합니다.

---

## 📅 요약: 우선순위 제안

| 우선순위 | 영역 | 작업 내용 | 기대 효과 |
| :--- | :--- | :--- | :--- |
| **P0 (즉시)** | **Storage** | **Migration Manager & Safe Write** | 유저 데이터 보호, 업데이트 시 크래시 방지 |
| **P1 (단기)** | **Arch** | **MatchEngine 분리 & Config 추출** | 유지보수성 확보, 밸런스 튜닝 용이 |
| **P2 (중기)** | **UI** | **Orchestrator 바인딩 교체** | 아키텍처 단일화, 기술 부채 해소 |
| **P3 (장기)** | **Perf** | **i18n & 리스트 최적화** | 글로벌 진출 준비, 대규모 리그 지원 |
