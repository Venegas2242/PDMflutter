class GameModel {
  final String name;
  final String shortDescription;
  final String longDescription;
  final String imagePath;
  final String imagePath2;
  bool isFavorite;

  GameModel({
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.imagePath,
    required this.imagePath2,
    this.isFavorite = false,
  });
}