import 'message.dart';
import 'package.dart';
import 'user.dart';

class Conversation {
  String? id;
  Message? lastMessage;
  List<String>? participants;
  List<User>? involved;
  String? createAt;
  String? updatedAt;
  dynamic unreadMessages;
  Package? package;
  Conversation({
    this.id,
    this.lastMessage,
    this.participants,
    this.involved,
    this.createAt,
    this.updatedAt,
    this.unreadMessages,
    this.package,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lastMessage': lastMessage?.toMap(),
      'participants': participants,
      'involved': involved!.map((x) => x.toMap()).toList(),
      'createAt': createAt,
      'updatedAt': updatedAt,
      'package': package!.toMessageMap(),
      'unreadMessages': unreadMessages as Map,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'] != null ? map['id'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? Message.fromMap(map['lastMessage'] as Map<String, dynamic>)
          : null,
      package: map['package'] != null
          ? Package.fromMessageMap(map['package'] as Map<String, dynamic>)
          : null,
      participants: map['participants'] != null
          ? List<String>.from((map['participants'] as List<dynamic>))
          : null,
      involved: map['involved'] != null
          ? List<User>.from(
              (map['involved'] as List<dynamic>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      createAt: map['createAt'] != null ? map['createAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      unreadMessages: map['unreadMessages'] != null
          ? map['unreadMessages'] as dynamic
          : null,
    );
  }
}
