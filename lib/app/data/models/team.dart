class Team {
  final String id;
  final String name;
  final String? photoUrl;
  final List<String> playerIds;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  Team({
    required this.id,
    required this.name,
    this.photoUrl,
    this.playerIds = const [],
    this.rating = 1000,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String?,
      playerIds: List<String>.from(map['playerIds'] ?? []),
      rating: map['rating'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'playerIds': playerIds,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
