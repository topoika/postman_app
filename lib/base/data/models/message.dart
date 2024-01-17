class Message {
  String? id;
  String? text;
  String? sendBy;
  String? createAt;
  List<String>? readBy;
  Message({
    this.id,
    this.text,
    this.sendBy,
    this.createAt,
    this.readBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'sendBy': sendBy,
      'createAt': createAt,
      'readBy': readBy,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      sendBy: map['sendBy'] != null ? map['sendBy'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as String : null,
      readBy: map['readBy'] != null
          ? List<String>.from((map['readBy'] as List<dynamic>))
          : null,
    );
  }
}
