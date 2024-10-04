class ArtworkDataModel {
  int artId;
  String artName;
  String imageUrl;
  String painter;
  String origin;
  String description;
  int minBidPrice;

  ArtworkDataModel({
    required this.artId,
    required this.artName,
    required this.imageUrl,
    required this.painter,
    required this.origin,
    required this.description,
    required this.minBidPrice,
  });

  // Factory constructor to create an instance of ArtworkDataModel from a Map.
  factory ArtworkDataModel.fromMap(Map<String, dynamic> data) {
    return ArtworkDataModel(
      artId: data['artId'],
      artName: data['artName'],
      imageUrl: data['imageUrl'],
      painter: data['painter'],
      origin: data['origin'],
      description: data['description'],
      minBidPrice: data['minBidPrice'],
    );
  }

  // Method to convert ArtworkDataModel to a Map.
  Map<String, dynamic> toMap() {
    return {
      'artId': artId,
      'artName': artName,
      'imageUrl': imageUrl,
      'painter': painter,
      'origin': origin,
      'description': description,
      'minBidPrice': minBidPrice,
    };
  }

  // Method to print a readable description of the artwork.
  @override
  String toString() {
    return 'ArtworkDataModel(artId: $artId, artName: $artName, imageUrl: $imageUrl, painter: $painter, origin: $origin, description: $description, minBidPrice: $minBidPrice)';
  }
}
