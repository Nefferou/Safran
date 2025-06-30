class UserStatsDto {
  final String userId;
  final int gamesPlayed;
  final int gamesWon;
  final int gamesLost;

  UserStatsDto({
    required this.userId,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.gamesLost,
  });

  factory UserStatsDto.fromJson(Map<String, dynamic> json) => UserStatsDto(
        userId: json['userId'],
        gamesPlayed: json['gamesPlayed'],
        gamesWon: json['gamesWon'],
        gamesLost: json['gamesLost'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'gamesPlayed': gamesPlayed,
        'gamesWon': gamesWon,
        'gamesLost': gamesLost,
      };
} 