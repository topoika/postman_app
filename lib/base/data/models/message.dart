import 'trip.dart';

class Message {
  String? id;
  String? text;
  String? sendBy;
  String? createAt;
  String? type;
  Trip? trip;
  Message({
    this.id,
    this.text,
    this.sendBy,
    this.createAt,
    this.type,
    this.trip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'sendBy': sendBy,
      'createAt': createAt,
      'type': type,
      "trip": trip != null ? trip!.toMessageMap() : null
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      sendBy: map['sendBy'] != null ? map['sendBy'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      trip: map['trip'] != null
          ? Trip.fromMessageMap((map['trip'] as Map<String, dynamic>))
          : null,
    );
  }
}
