# DOMAIN_MODEL.md — 도메인 모델 정의(Flutter/Dart)

## 1. 설계 원칙
- 도메인 모델은 UI/Flutter 의존이 없어야 한다.
- 게임 상태는 스냅샷으로 저장 가능한 형태(불변 데이터 권장).
- 확장(이벤트 추가/리그 추가)을 위해 enum/테이블 기반 설계를 선호한다.

## 2. 핵심 타입 목록
### 2.1 PlayerCharacter(PC)
- id: String(ULID/UUID)
- profile: PlayerProfile
- stats: PlayerStats
- status: PlayerStatus
- career: PlayerCareer

### 2.2 Season
- seasonId, year
- currentRound: int
- fixtures: List<Fixture>
- standings: List<StandingRow>
- teams: Map<TeamId, Team>

### 2.3 MatchSession
- matchId
- opponentTeamId
- phase: MatchPhase
- minute: int
- score: Score
- highlightQueue: List<HighlightEvent>
- log: List<LogLine>
- ratingAccumulator: RatingAccumulator
- rngSeed: int

### 2.4 GameSnapshot(루트)
- version: int
- savedAt: ISO8601
- gameState: GameState
- pc: PlayerCharacter
- season: Season
- activeMatch: MatchSession?

## 3. 상세 필드(권장 스키마)
### PlayerStats (0~100)
- pace
- shooting
- passing
- ballControl
- positioning
- stamina
- composure

### PlayerStatus
- fatigue: 0..100
- confidence: -3..+3
- injury: InjuryStatus
- form: FormTrend (최근 3경기 평점 기반)

### PlayerCareer
- level: int
- xp: int
- trust: 0..100
- reputation: 0..100
- lastRatings: List<double> (최근 10경기)

## 4. 텍스트/로깅 모델
### LogLine
- minute: int?
- type: LogType (COMMENTARY/RESULT/SYSTEM)
- text: String
- tags: Map<String,String> (선택)

## 5. 커맨드 모델
### Command
- type: CommandType
- payload: Map<String,dynamic> (옵션: 예, 패스 방향)
- issuedAt: timestamp (선택)

CommandType 예시:
- SHOOT, PASS, DRIBBLE, SAFE_PLAY
- PRESS, CONTAIN, TACKLE, FALL_BACK
- COMPOSE, FORCE_PLAY, CALL_FOR_BALL

## 6. 버전/마이그레이션
- GameSnapshot.version을 증가시키며 하위 호환 마이그레이션 함수 제공
- 저장 실패 시 마지막 정상 스냅샷으로 롤백
