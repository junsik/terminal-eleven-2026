# 아키텍처 개요

## 기술 스택

| 기술 | 용도 |
|------|------|
| **Flutter** | UI 프레임워크 (Dart SDK ^3.10.7) |
| **Riverpod** | 상태 관리 |
| **GoRouter** | 라우팅 |
| **Freezed** | 불변 데이터 모델 |
| **Hive** | 로컬 저장소 |

## 아키텍처 패턴

### Single Source of Truth (SSOT)

게임의 모든 상태는 단일 `GameState` 객체에서 관리됩니다:

```
GameState (유일한 상태 원천)
├── PlayerState (플레이어 캐릭터, 주간 행동)
├── SeasonState (시즌, 팀, 경기 일정, 순위표)
├── UIScreenState (현재 화면, 진행 중인 경기)
├── InboxState (메시지)
└── MetaState (버전, 저장 시간)
```

### Pure Function Engine

모든 게임 로직은 **순수 함수**로 구현됩니다:

```dart
(State, Action, Seed) → State'
```

- **입력**: 현재 상태 + 액션 + 난수 시드
- **출력**: 새로운 상태 (부작용 없음)
- **장점**:
  - 테스트 용이
  - 결정론적 결과 (같은 입력 → 같은 출력)
  - 리플레이 가능

## 디렉토리 구조

```
lib/
├── app/                    # 앱 설정, 라우팅
│   ├── app.dart
│   └── routes.dart
├── application/            # 비즈니스 로직
│   ├── orchestrator.dart   # 게임 오케스트레이터
│   └── providers.dart      # Riverpod 프로바이더
├── data/                   # 데이터 레이어
│   └── storage/
│       └── hive_store.dart
├── domain/                 # 도메인 레이어
│   ├── action/             # 액션 정의
│   ├── config/             # 밸런스 설정
│   ├── engine/             # 순수 함수 엔진들
│   ├── model/              # 데이터 모델 (Freezed)
│   ├── state/              # 게임 상태
│   └── text/               # 텍스트/해설
└── presentation/           # UI 레이어
    ├── home/
    ├── training/
    ├── match/
    └── ...
```

## 주요 컴포넌트

| 컴포넌트 | 역할 |
|---------|------|
| `GameOrchestrator` | 액션 디스패치, 엔진 라우팅 |
| `GameStateStore` | 상태 저장소 (ChangeNotifier) |
| `TrainingEngine` | 훈련 로직 |
| `MatchEngine` | 경기 로직 |
| `LeagueEngineV2` | 리그/순위 로직 |
| `CareerEngine` | 커리어 통계 |

## 데이터 흐름

```
┌─────────────────────────────────────────────────────┐
│                    UI Layer                          │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐       │
│  │HomeScreen │  │MatchScreen│  │TrainingScr│ ...   │
│  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘       │
│        │              │              │              │
│        └──────────────┼──────────────┘              │
│                       ▼                             │
│              ┌────────────────┐                     │
│              │  Orchestrator  │ ◄─── dispatch()    │
│              └────────┬───────┘                     │
│                       │                             │
│        ┌──────────────┼──────────────┐              │
│        ▼              ▼              ▼              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │ Training │  │  Match   │  │  League  │  Engine │
│  │  Engine  │  │  Engine  │  │  Engine  │         │
│  └──────────┘  └──────────┘  └──────────┘         │
│                       │                             │
│                       ▼                             │
│              ┌────────────────┐                     │
│              │   GameState    │ ◄─── 새 상태       │
│              └────────────────┘                     │
│                       │                             │
│                       ▼                             │
│              ┌────────────────┐                     │
│              │   Hive Store   │ ◄─── 자동 저장     │
│              └────────────────┘                     │
└─────────────────────────────────────────────────────┘
```

---

다음: [[Pure Function Engine|Pure-Function-Engine]]
