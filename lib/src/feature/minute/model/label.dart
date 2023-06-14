enum Label {
  fistPray('first_pray'),
  endingPray('ending_pray'),
  firstSpeaker('first_speaker'),
  secondSpeaker('second_speaker'),
  thirdSpeaker('third_speaker'),
  firstHymn('first_hym'),
  sacramentalHym('sacramental_hym'),
  intermediaryHym('intermediary_hym'),
  endingHymn('ending_hym'),
  testimony('testimony'),
  announcement('announcement'),
  driving('driving'),
  presiding('presiding'),
  recognition('recognition'),
  call('call'),
  callRelease('call_release'),
  confirmation('confirmation'),
  message('message'),
  regent('regent'),
  presentingChild('presenting_child');

  final String value;

  const Label(this.value);
}
