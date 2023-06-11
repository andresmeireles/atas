import 'package:atas/src/feature/minute/minute.dart';

enum Schema {
  sacramental('sacramental');

  final String value;

  const Schema(this.value);

  MinuteShape get shape {
    switch (value) {
      case 'sacramental':
        return SacramentalShape();
      default:
        return SacramentalShape();
    }
  }
}
