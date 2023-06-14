import 'package:atas/src/feature/minute/minute.dart';

final class SacramentalShape implements MinuteShape {
  @override
  final List<Label> obligatory = [
    Label.driving,
    Label.presiding,
    Label.fistPray,
    Label.endingPray,
    Label.firstHymn,
    Label.sacramentalHym,
    Label.endingHymn,
    Label.presiding,
    Label.firstSpeaker,
    Label.thirdSpeaker,
  ];

  @override
  final List<Label> optional = [
    Label.recognition,
    Label.regent,
    Label.call,
    Label.callRelease,
    Label.confirmation,
    Label.intermediaryHym,
    Label.secondSpeaker,
    Label.presentingChild,
    Label.announcement
  ];
}
