class HotsDataModel {
  int artId;
  String artName;
  String imageUrl;
  String painter;
  String origin;
  String description;
  int minBidPrice;

  HotsDataModel({
    required this.artId,
    required this.artName,
    required this.imageUrl,
    required this.painter,
    required this.origin,
    required this.description,
    required this.minBidPrice,
  });

  factory HotsDataModel.toMap({required Map data}) {
    return HotsDataModel(
      artId: data['artId'],
      artName: data['artName'],
      imageUrl: data['imageUrl'],
      painter: data['painter'],
      origin: data['origin'],
      description: data['description'],
      minBidPrice: data['minBidPrice'],
    );
  }
}
