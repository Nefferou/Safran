class UserPreferencesDto {
  final String userId;
  final bool darkMode;
  final String language;

  UserPreferencesDto({
    required this.userId,
    required this.darkMode,
    required this.language,
  });

  factory UserPreferencesDto.fromJson(Map<String, dynamic> json) => UserPreferencesDto(
        userId: json['userId'],
        darkMode: json['darkMode'] == 1,
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'darkMode': darkMode ? 1 : 0,
        'language': language,
      };
} 