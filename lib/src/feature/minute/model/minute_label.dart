enum MinuteLabel {
  musicConductor,
  firstPray,
  lastPray,
  firstSpeaker,
  lastSpeaker,
  secondSpeaker,
  confirmation,
  namingChild,
  testimony,
  heading,
  presiding,
  firstHymn,
  sacramentalHymn,
  intermediaryHymn,
  specialHymn,
  lastHymn,
  call,
  callRelease,
  announcement,
  acknowledgment,
  createdAt,
  updatedAt,
  createdBy,
  updatedBy,
  meetingDate,
}

extension NamesMinuteLabel on MinuteLabel {
  String get descriptionName {
    switch (this) {
      case MinuteLabel.call:
        return 'chamados';
      case MinuteLabel.presiding:
        return 'presidindo';
      case MinuteLabel.musicConductor:
        return 'regente';
      case MinuteLabel.firstPray:
        return 'primeira oração';
      case MinuteLabel.lastPray:
        return 'oração de encerramento';
      case MinuteLabel.firstSpeaker:
        return 'primeiro orador';
      case MinuteLabel.lastSpeaker:
        return 'ultimo orador';
      case MinuteLabel.secondSpeaker:
        return 'segundo orador';
      case MinuteLabel.confirmation:
        return 'confirmação';
      case MinuteLabel.namingChild:
        return 'nome a criança';
      case MinuteLabel.testimony:
        return 'testemunho';
      case MinuteLabel.heading:
        return 'dirigindo';
      case MinuteLabel.firstHymn:
        return 'primeiro hino';
      case MinuteLabel.specialHymn:
        return 'hino especial';
      case MinuteLabel.sacramentalHymn:
        return 'hino sacramental';
      case MinuteLabel.intermediaryHymn:
        return 'hino intermediário';
      case MinuteLabel.lastHymn:
        return 'hino de encerramento';
      case MinuteLabel.callRelease:
        return 'desobrigação';
      case MinuteLabel.announcement:
        return 'anúncios';
      case MinuteLabel.acknowledgment:
        return 'reconhecimentos';
      case MinuteLabel.createdAt:
      case MinuteLabel.updatedAt:
      case MinuteLabel.createdBy:
      case MinuteLabel.updatedBy:
        return 'outros';
      case MinuteLabel.meetingDate:
        return 'data da reunião';
    }
  }
}
