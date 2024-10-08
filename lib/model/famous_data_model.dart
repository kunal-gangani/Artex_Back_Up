class FamousDataModel {
  int artId;
  String artName;
  String imageUrl;
  String painter;
  String origin;
  String description;
  int minBidPrice;
  int stock;

  FamousDataModel({
    required this.artId,
    required this.artName,
    required this.imageUrl,
    required this.painter,
    required this.origin,
    required this.description,
    required this.minBidPrice,
    required this.stock,
  });

  factory FamousDataModel.toMap({
    required Map data,
  }) {
    return FamousDataModel(
      artId: data['artId'],
      artName: data['artName'],
      imageUrl: data['imageUrl'],
      painter: data['painter'],
      origin: data['origin'],
      description: data['description'],
      minBidPrice: data['minBidPrice'],
      stock: data['stock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'artId': artId,
      'artName': artName,
      'imageUrl': imageUrl,
      'painter': painter,
      'origin': origin,
      'description': description,
      'minBidPrice': minBidPrice,
      'stock': stock,
    };
  }
}
