class Game {
  final String id;
  final String team1Id;
  final String team2Id;
  final int team1Score;
  final int team2Score;
  final DateTime gameDate;
  final String status; // 'scheduled', 'in_progress', 'completed', 'cancelled'
  final String sport;
  final DateTime createdAt;
  final DateTime updatedAt;

  Game({
    required this.id,
    required this.team1Id,
    required this.team2Id,
    this.team1Score = 0,
    this.team2Score = 0,
    required this.gameDate,
    this.status = 'scheduled',
    required this.sport,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as String,
      team1Id: map['team1Id'] as String,
      team2Id: map['team2Id'] as String,
      team1Score: map['team1Score'] as int,
      team2Score: map['team2Score'] as int,
      gameDate: DateTime.parse(map['gameDate'] as String),
      status: map['status'] as String,
      sport: map['sport'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team1Id': team1Id,
      'team2Id': team2Id,
      'team1Score': team1Score,
      'team2Score': team2Score,
      'gameDate': gameDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
