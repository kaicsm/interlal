class Player {
  final String id;
  final String name;
  final String? photoUrl;
  final String? teamId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Player({
    required this.id,
    required this.name,
    this.photoUrl,
    this.teamId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String?,
      teamId: map['teamId'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'teamId': teamId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
