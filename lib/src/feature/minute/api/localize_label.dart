import '../minute.dart';

class LocalizeLabel {
  // TODO: add suport for languages
  String label(MinuteLabel label) {
    switch (label) {
      case MinuteLabel.acknowledgment:
        return 'reconhecimento';
      case MinuteLabel.announcement:
        return 'anuncio';
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
      case MinuteLabel.presiding:
        return 'presidindo';
      case MinuteLabel.firstHymn:
        return 'hino inicial';
      case MinuteLabel.sacramentalHymn:
        return 'hino sacramental';
      case MinuteLabel.intermediaryHymn:
        return 'hino intermediário';
      case MinuteLabel.specialHymn:
        return 'hino especial';
      case MinuteLabel.lastHymn:
        return 'hino de encerramento';
      case MinuteLabel.call:
        return 'chamado';
      case MinuteLabel.callRelease:
        return 'desobrigação';
      case MinuteLabel.createdAt:
        return 'criado em';
      case MinuteLabel.updatedAt:
        return 'atualizado em';
      case MinuteLabel.createdBy:
        return 'criado por';
      case MinuteLabel.updatedBy:
        return 'editado por';
      case MinuteLabel.meetingDate:
        return 'data da reunião';
    }
  }
}
