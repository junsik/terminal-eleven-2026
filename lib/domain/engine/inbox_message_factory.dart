/// 인박스 메시지 팩토리
///
/// 게임 이벤트에 따른 메시지 생성 헬퍼

import '../action/game_action.dart';
import '../model/player.dart';

/// 인박스 메시지 생성 팩토리
class InboxMessageFactory {
  InboxMessageFactory._();

  /// 새 게임 환영 메시지
  static AddInboxMessage welcome(String playerName, String teamName) {
    return AddInboxMessage(
      senderType: 'system',
      category: 'welcome',
      subject: 'MUD 축구에 오신 것을 환영합니다!',
      content:
          '$playerName 선수님, $teamName에 입단을 축하드립니다! 무명 유망주에서 시작해 스타 선수로 성장하는 여정을 시작하세요.',
    );
  }

  /// 훈련 완료 메시지 (코치)
  static AddInboxMessage? trainingComplete({
    required String trainingType,
    required int statGain,
    required int fatigue,
    required int trust,
  }) {
    // 피로도가 높을 때만 메시지
    if (fatigue >= 80) {
      return AddInboxMessage(
        senderType: 'coach',
        category: 'training',
        subject: '컨디션 관리에 주의하세요',
        content: '최근 훈련 강도가 높았어. 피로도가 $fatigue%까지 올라갔으니 무리하지 말고 충분히 쉬어.',
      );
    }

    // 신뢰도에 따른 메시지
    if (trust < 30) {
      return AddInboxMessage(
        senderType: 'coach',
        category: 'trust',
        subject: '더 분발해야 해',
        content: '최근 훈련 태도가 기대에 미치지 못하고 있어. 더 열심히 해줘야 기회를 줄 수 있어.',
      );
    }

    return null; // 특별한 상황 아니면 메시지 없음
  }

  /// 경기 결과 메시지
  static AddInboxMessage matchResult({
    required bool isWin,
    required bool isDraw,
    required int homeScore,
    required int awayScore,
    required double rating,
    required int goals,
    required int assists,
    required String opponentName,
    required bool isHome,
  }) {
    final result = isWin ? '승리' : (isDraw ? '무승부' : '패배');
    final score = isHome
        ? '$homeScore : $awayScore'
        : '$awayScore : $homeScore';

    String subject;
    String content;
    String senderType;

    // 높은 평점 - 미디어/팬 반응
    if (rating >= 8.0) {
      senderType = 'media';
      subject = '[$result] 환상적인 활약!';
      content = '$opponentName전에서 평점 ${rating.toStringAsFixed(1)}의 맹활약! '
          '${goals > 0 ? "$goals골 " : ""}${assists > 0 ? "$assists어시스트 " : ""}'
          '오늘 경기의 최고 선수였습니다.';
    } else if (rating >= 7.0) {
      senderType = 'coach';
      subject = '[$result] 좋은 경기였어';
      content = '$opponentName전 ($score) 오늘 활약이 좋았어. 평점 ${rating.toStringAsFixed(1)}. '
          '이대로만 해줘.';
    } else if (rating < 5.5) {
      senderType = 'coach';
      subject = '[$result] 아쉬운 경기';
      content = '$opponentName전 ($score) 오늘은 기대에 못 미쳤어. 평점 ${rating.toStringAsFixed(1)}. '
          '다음에는 더 잘해보자.';
    } else {
      senderType = 'fan';
      subject = '[$result] 경기 결과';
      content = '$opponentName전 $score로 $result했습니다. 다음 경기도 응원합니다!';
    }

    return AddInboxMessage(
      senderType: senderType,
      category: 'matchResult',
      subject: subject,
      content: content,
    );
  }

  /// 레벨업 메시지
  static AddInboxMessage levelUp(int newLevel) {
    if (newLevel <= 3) {
      return AddInboxMessage(
        senderType: 'agent',
        category: 'levelUp',
        subject: '레벨 $newLevel 달성!',
        content: '레벨 $newLevel까지 성장했군요! 아직 갈 길이 멀지만, 이대로 꾸준히 성장하면 좋은 미래가 기다리고 있을 거예요.',
      );
    } else if (newLevel <= 7) {
      return AddInboxMessage(
        senderType: 'agent',
        category: 'levelUp',
        subject: '레벨 $newLevel - 성장 중!',
        content: '레벨 $newLevel! 확실히 눈에 띄는 성장이에요. 슬슬 다른 팀에서도 관심을 보일지도 모르겠네요.',
      );
    } else {
      return AddInboxMessage(
        senderType: 'agent',
        category: 'levelUp',
        subject: '레벨 $newLevel - 주목받는 선수!',
        content: '레벨 $newLevel까지 오르셨군요! 이제 리그에서도 주목받는 선수가 되었어요. 빅클럽에서 제안이 올 수도 있습니다.',
      );
    }
  }

  /// 부상 메시지
  static AddInboxMessage injury(InjuryStatus injury, int weeksOut) {
    final severityText = switch (injury) {
      InjuryStatus.minor => '경미한',
      InjuryStatus.moderate => '중간 정도의',
      InjuryStatus.severe => '심각한',
      _ => '',
    };

    return AddInboxMessage(
      senderType: 'system',
      category: 'injury',
      subject: '부상 발생',
      content: '$severityText 부상을 입었습니다. 예상 결장 기간: $weeksOut경기. 충분한 휴식을 취하세요.',
    );
  }

  /// 부상 회복 메시지
  static AddInboxMessage injuryRecovered() {
    return const AddInboxMessage(
      senderType: 'coach',
      category: 'injury',
      subject: '복귀를 환영해!',
      content: '부상에서 완전히 회복됐군. 다시 그라운드에서 뛸 수 있게 되어 기쁘다. 무리하지 말고 천천히 컨디션을 올려가자.',
    );
  }

  /// 신뢰도 변화 메시지
  static AddInboxMessage? trustChange(int oldTrust, int newTrust) {
    final delta = newTrust - oldTrust;

    // 큰 변화가 있을 때만
    if (delta >= 10) {
      return AddInboxMessage(
        senderType: 'coach',
        category: 'trust',
        subject: '팀의 핵심이 되어가고 있어',
        content: '최근 활약이 매우 좋아. 너에 대한 신뢰가 높아지고 있어. 앞으로 더 많은 기회를 주겠다.',
      );
    } else if (delta <= -10) {
      return AddInboxMessage(
        senderType: 'coach',
        category: 'trust',
        subject: '기대에 미치지 못하고 있어',
        content: '최근 경기력이 좋지 않아. 이대로라면 출전 기회가 줄어들 수 있어. 훈련에 더 집중해줘.',
      );
    }

    // 임계값 도달
    if (newTrust >= 80 && oldTrust < 80) {
      return const AddInboxMessage(
        senderType: 'coach',
        category: 'trust',
        subject: '주전 자리를 굳혔어',
        content: '너는 이제 팀의 핵심이야. 주전 자리는 네 것이다. 팀을 이끌어줘.',
      );
    } else if (newTrust < 20 && oldTrust >= 20) {
      return const AddInboxMessage(
        senderType: 'coach',
        category: 'trust',
        subject: '마지막 기회야',
        content: '솔직히 말할게. 지금 상태라면 로스터에서 빠질 수도 있어. 제발 정신 차려.',
      );
    }

    return null;
  }

  /// 마일스톤 메시지 (첫 골, 10골 등)
  static AddInboxMessage? milestone({
    required int totalGoals,
    required int totalAssists,
    required int matchesPlayed,
  }) {
    // 첫 골
    if (totalGoals == 1) {
      return const AddInboxMessage(
        senderType: 'fan',
        category: 'milestone',
        subject: '첫 골 축하합니다!',
        content: '프로 커리어 첫 골을 넣으셨군요! 이 순간을 절대 잊지 마세요. 앞으로 더 많은 골을 기대합니다!',
      );
    }

    // 10골 단위
    if (totalGoals > 0 && totalGoals % 10 == 0) {
      return AddInboxMessage(
        senderType: 'media',
        category: 'milestone',
        subject: '통산 $totalGoals골 달성!',
        content: '통산 $totalGoals골을 기록하셨습니다! 꾸준한 득점력을 보여주고 계시네요.',
      );
    }

    // 50경기 단위
    if (matchesPlayed > 0 && matchesPlayed % 50 == 0) {
      return AddInboxMessage(
        senderType: 'system',
        category: 'milestone',
        subject: '통산 $matchesPlayed경기 출전',
        content: '프로 커리어 $matchesPlayed경기 출전을 달성하셨습니다!',
      );
    }

    return null;
  }

  /// 폼 변화 메시지
  static AddInboxMessage? formChange(FormTrend oldForm, FormTrend newForm) {
    if (oldForm == newForm) return null;

    if (newForm == FormTrend.excellent && oldForm != FormTrend.excellent) {
      return const AddInboxMessage(
        senderType: 'media',
        category: 'form',
        subject: '최고의 폼!',
        content: '최근 경기에서 뛰어난 활약을 펼치고 있습니다! 리그 최고의 선수들과 어깨를 나란히 하고 있어요.',
      );
    } else if (newForm == FormTrend.poor && oldForm != FormTrend.poor) {
      return const AddInboxMessage(
        senderType: 'coach',
        category: 'form',
        subject: '슬럼프인가?',
        content: '최근 컨디션이 좋지 않아 보여. 걱정하지 마. 모든 선수에게 힘든 시기가 있어. 기본기에 집중하자.',
      );
    }

    return null;
  }
}
