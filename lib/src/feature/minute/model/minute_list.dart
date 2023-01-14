import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MinuteList {
  final String name;
  final MinuteListStatus status;

  MinuteList({required this.name, required this.status});

  Map<String, dynamic> toMap() => <String, dynamic>{'name': name, 'status': status.toString()};

  factory MinuteList.fromMap(Map<String, dynamic> map) {
    return MinuteList(
      name: map['name'] as String,
      status: MinuteListStatus.values.firstWhere((element) => element.toString() == (map['status'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory MinuteList.fromJson(String source) => MinuteList.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum MinuteListStatus { draw, closed }

extension Names on MinuteListStatus {
  String get statusName {
    switch (this) {
      case MinuteListStatus.draw:
        return 'rascunho';
      case MinuteListStatus.closed:
        return 'finalizado';
    }
  }
}
