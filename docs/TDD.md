# TDD.md (Technical Design Document) — Flutter/Dart

## 1. 기술 스택
- Flutter (Dart), Material 3
- 상태관리: Riverpod(권장), 필요 시 StateNotifier 기반
- 저장: Hive(스냅샷), Drift(SQLite)(기록/통계 장기 저장 선택)
- 로깅: `logger` 패키지 + 게임 로그는 별도 도메인 로그로 분리
- 테스트: `flutter_test`, `test`, `mocktail`

## 2. 아키텍처(권장 구조)
### 레이어
- Presentation(UI): 화면 위젯, 단순 렌더링
- Application(ViewModel/UseCase): 상태 전환/유스케이스
- Domain: 엔진/규칙/모델 (Flutter 의존 없음)
- Data: 저장/로드, 마이그레이션, 리포지토리

### 폴더 구조(예시)
```text
lib/
  app/
    app.dart
    routes.dart
  presentation/
    home/
    training/
    match/
    summary/
    career/
    inbox/
    widgets/
  application/
    game_controller.dart
    usecases/
      start_new_career.dart
      run_training_day.dart
      play_match_highlights.dart
      apply_post_match.dart
    providers.dart
  domain/
    model/
    engine/
    rules/
    text/
  data/
    storage/
      hive_store.dart
      drift_db.dart
    repositories/
      game_repository.dart
      season_repository.dart
test/
docs/
```

## 3. 상태관리 설계(Riverpod)
- `gameStateProvider`: 전역 상태(홈/훈련/경기/요약 등)
- `gameControllerProvider`: 이벤트 처리(커맨드 입력 → 상태 갱신)
- `matchViewProvider`: 현재 경기 뷰 전용(로그, 선택지, 진행률)

### 원칙
- UI는 상태를 읽고 그릴 뿐, 엔진 호출은 Controller에서만 한다.
- 도메인 엔진은 pure function에 가깝게 유지한다(테스트 용이).

## 4. 주요 유스케이스(UseCases)
- StartNewCareer: PC 생성, 팀/리그/시즌 초기화
- RunTrainingDay: 훈련 선택 적용, 피로/성장/부상 체크
- PlayMatchHighlights: 하이라이트 생성, 선택 입력 처리 루프
- ApplyPostMatch: 평점/신뢰/경험치/기록 반영, 다음 라운드 이동
- SaveSnapshot / LoadSnapshot: 스냅샷 저장/복원

## 5. 데이터 계약(Serialization)
- 도메인 모델은 `toJson/fromJson`을 기본 제공(Freezed/JsonSerializable 권장)
- 스냅샷은 **단일 JSON 루트**로 구성(버전 포함)
- Drift 사용 시, 경기/시즌 통계만 정규화 저장(옵션)

## 6. 성능/UX 고려
- 텍스트 로그는 200~400줄 이상 누적 시 가상화(ListView.builder) 사용
- 하이라이트는 한 번에 1개만 렌더링(선택 → 결과 → 다음)
- 애니메이션은 최소(텍스트 타이핑 속도 옵션 제공)

## 7. 관측/디버깅
- 시드 고정으로 재현 가능한 경기(버그 리포트 용이)
- “자동 플레이 봇”으로 1,000경기 시뮬레이션(밸런스 회귀 감지)
