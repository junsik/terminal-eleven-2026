# Terminal Eleven (Project Prodigy)

**텍스트 기반 축구 커리어 시뮬레이션 게임** - Flutter로 구현된 MUD(Multi-User Dungeon) 스타일 축구 게임

## 📖 게임 소개

18세 무명 유망주로 시작해 스타 선수가 되는 여정을 경험하세요!

- **하이라이트 기반 경기**: 매 경기 핵심 순간에서 전략적 선택
- **성장 시스템**: 훈련으로 스탯 향상, XP로 레벨업
- **K리그 시스템**: 10개 팀, 18라운드 시즌
- **레트로 터미널 UI**: Matrix 스타일 그린 테마

## 🚀 실행 방법

### 사전 요구 사항
- Flutter 3.27+
- Windows: Developer Mode 활성화 필요

```bash
# Windows Developer Mode 활성화
start ms-settings:developers
```

### 실행
```bash
# 의존성 설치
flutter pub get

# 코드 생성 (Freezed)
dart run build_runner build

# Windows 실행
flutter run -d windows

# Android 실행
flutter run -d android
```

## 🎯 게임 플레이

1. **로비**: 선수 이름, 플레이 스타일, 소속팀 선택
2. **홈**: 대시보드에서 상태 확인 및 다음 행동 결정
3. **훈련**: 8종 훈련으로 스탯 향상 (주 3회 제한)
4. **경기**: 하이라이트에서 선택 → 결과 확인 → 반복
5. **결과**: 평점 확인, 커리어 성장 확인

## 🛠️ 기술 스택

- **Framework**: Flutter
- **State Management**: Riverpod
- **Navigation**: go_router
- **Data Models**: Freezed + json_serializable
- **Persistence**: Hive

## 📁 프로젝트 구조

```
lib/
├── app/           # 앱 설정, 라우팅
├── domain/        # 도메인 모델, 경기 엔진
├── application/   # 게임 컨트롤러, 프로바이더
├── data/          # Hive 저장소
└── presentation/  # UI 화면, 테마
```

## 📄 라이선스

MIT License
