// 도메인 모델 - 커맨드

import 'package:freezed_annotation/freezed_annotation.dart';

part 'command.freezed.dart';
part 'command.g.dart';

/// 커맨드 타입
enum CommandType {
  // 공격 행동
  @JsonValue('shoot')
  shoot, // 슈팅
  @JsonValue('pass')
  pass, // 패스
  @JsonValue('dribble')
  dribble, // 드리블
  @JsonValue('safePlay')
  safePlay, // 안전한 플레이

  // 수비 행동
  @JsonValue('press')
  press, // 압박
  @JsonValue('contain')
  contain, // 각도 차단
  @JsonValue('tackle')
  tackle, // 태클
  @JsonValue('fallBack')
  fallBack, // 후퇴

  // 특수 행동
  @JsonValue('compose')
  compose, // 진정
  @JsonValue('forcePlay')
  forcePlay, // 무리한 플레이
  @JsonValue('callForBall')
  callForBall, // 공 요청

  // 코치 피드백 반응
  @JsonValue('accept')
  accept, // 수용
  @JsonValue('askRole')
  askRole, // 역할 질문
  @JsonValue('ignore')
  ignore, // 무시

  // 세트피스 / 킥 옵션
  @JsonValue('chipShot')
  chipShot, // 칩슛
  @JsonValue('knuckleShot')
  knuckleShot, // 무회전
  @JsonValue('panenka')
  panenka, // 파넨카
  @JsonValue('powerShot')
  powerShot, // 강슛
  @JsonValue('curvedShot')
  curvedShot, // 감아차기
  
  // 전술 외침
  @JsonValue('shoutEncourage')
  shoutEncourage, // 격려
  @JsonValue('shoutDemand')
  shoutDemand, // 질책/요구
  @JsonValue('shoutCalm')
  shoutCalm, // 진정
}

/// 커맨드 정보
@freezed
class Command with _$Command {
  const factory Command({
    required CommandType type,
    @Default({}) Map<String, dynamic> payload, // 추가 데이터
    DateTime? issuedAt,
  }) = _Command;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);
}

/// 커맨드 타입 확장
extension CommandTypeX on CommandType {
  /// 한국어 이름
  String get displayName {
    switch (this) {
      case CommandType.shoot:
        return '슈팅';
      case CommandType.pass:
        return '패스';
      case CommandType.dribble:
        return '드리블';
      case CommandType.safePlay:
        return '안전한 플레이';
      case CommandType.press:
        return '압박';
      case CommandType.contain:
        return '각도 차단';
      case CommandType.tackle:
        return '태클';
      case CommandType.fallBack:
        return '후퇴';
      case CommandType.compose:
        return '진정';
      case CommandType.forcePlay:
        return '무리한 시도';
      case CommandType.callForBall:
        return '공 요청';
      case CommandType.accept:
        return '수용';
      case CommandType.askRole:
        return '역할 질문';
      case CommandType.ignore:
        return '무시';
      case CommandType.chipShot:
        return '칩슛';
      case CommandType.knuckleShot:
        return '무회전';
      case CommandType.panenka:
        return '파넨카';
      case CommandType.powerShot:
        return '강슛';
      case CommandType.curvedShot:
        return '감아차기';
      case CommandType.shoutEncourage:
        return '격려';
      case CommandType.shoutDemand:
        return '질책';
      case CommandType.shoutCalm:
        return '진정';
    }
  }

  /// 커맨드 설명
  String get description {
    switch (this) {
      case CommandType.shoot:
        return '골을 노리고 슈팅합니다';
      case CommandType.pass:
        return '팀 동료에게 패스합니다';
      case CommandType.dribble:
        return '상대를 제치고 전진합니다';
      case CommandType.safePlay:
        return '위험을 줄이고 안전하게 플레이합니다';
      case CommandType.press:
        return '상대를 강하게 압박합니다';
      case CommandType.contain:
        return '상대의 진로를 차단합니다';
      case CommandType.tackle:
        return '과감하게 태클합니다 (카드/부상 위험)';
      case CommandType.fallBack:
        return '뒤로 물러서 수비 라인을 유지합니다';
      case CommandType.compose:
        return '침착하게 루틴을 되찾습니다';
      case CommandType.forcePlay:
        return '무리해서 찬스를 시도합니다 (실수 위험)';
      case CommandType.callForBall:
        return '침투하며 공을 요청합니다';
      case CommandType.accept:
        return '코치의 지시를 수용합니다';
      case CommandType.askRole:
        return '자신의 역할에 대해 질문합니다';
      case CommandType.ignore:
        return '코치의 지시를 무시합니다';
      case CommandType.chipShot:
        return '키퍼 키를 넘기는 칩슛을 시도합니다';
      case CommandType.knuckleShot:
        return '예측 불가능한 무회전 슛을 날립니다';
      case CommandType.panenka:
        return '대범하게 중앙으로 툭 찹니다 (높은 위험)';
      case CommandType.powerShot:
        return '골망을 찢을 듯한 강슛을 날립니다';
      case CommandType.curvedShot:
        return '수비를 피해 구석으로 감아찹니다';
      case CommandType.shoutEncourage:
        return '동료들의 사기를 북돋습니다';
      case CommandType.shoutDemand:
        return '더 좋은 플레이를 강력하게 요구합니다';
      case CommandType.shoutCalm:
        return '흥분한 동료들을 진정시킵니다';
    }
  }

  /// 공격 행동인지
  bool get isOffensive =>
      this == CommandType.shoot ||
      this == CommandType.pass ||
      this == CommandType.dribble ||
      this == CommandType.callForBall;

  /// 수비 행동인지
  bool get isDefensive =>
      this == CommandType.press ||
      this == CommandType.contain ||
      this == CommandType.tackle ||
      this == CommandType.fallBack;

  /// 위험한 행동인지
  bool get isRisky =>
      this == CommandType.tackle ||
      this == CommandType.forcePlay ||
      this == CommandType.dribble ||
      this == CommandType.panenka || // 파넨카는 매우 위험
      this == CommandType.knuckleShot;
}

/// 커맨드 String -> CommandType 변환
CommandType? commandTypeFromString(String value) {
  switch (value.toLowerCase()) {
    case 'shoot':
      return CommandType.shoot;
    case 'pass':
      return CommandType.pass;
    case 'dribble':
      return CommandType.dribble;
    case 'safeplay':
    case 'safe_play':
      return CommandType.safePlay;
    case 'press':
      return CommandType.press;
    case 'contain':
      return CommandType.contain;
    case 'tackle':
      return CommandType.tackle;
    case 'fallback':
    case 'fall_back':
      return CommandType.fallBack;
    case 'compose':
      return CommandType.compose;
    case 'forceplay':
    case 'force_play':
      return CommandType.forcePlay;
    case 'callforball':
    case 'call_for_ball':
      return CommandType.callForBall;
    case 'accept':
      return CommandType.accept;
    case 'askrole':
    case 'ask_role':
      return CommandType.askRole;
    case 'ignore':
      return CommandType.ignore;
    case 'chipshot':
    case 'chip_shot':
      return CommandType.chipShot;
    case 'knuckleshot':
    case 'knuckle_shot':
      return CommandType.knuckleShot;
    case 'panenka':
      return CommandType.panenka;
    case 'powershot':
    case 'power_shot':
      return CommandType.powerShot;
    case 'curvedshot':
    case 'curved_shot':
      return CommandType.curvedShot;
    case 'shoutencourage':
      return CommandType.shoutEncourage;
    case 'shoutdemand':
      return CommandType.shoutDemand;
    case 'shoutcalm':
      return CommandType.shoutCalm;
    default:
      return null;
  }
}
