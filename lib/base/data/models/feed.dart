import 'user.dart';

class Feed {
  String? id;
  String? title;
  String? description;
  User? createBy;
  String? createdAt;
  Feed({
    this.id,
    this.title,
    this.description,
    this.createBy,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createBy': createBy?.toMap(),
      'createdAt': createdAt,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createBy: map['createBy'] != null
          ? User.fromMap(map['createBy'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
