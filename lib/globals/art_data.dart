import 'package:minor_project/model/famous_data_model.dart';
import 'package:minor_project/model/hots_data_model.dart';
import 'package:minor_project/model/house_holds_data_model.dart';

List<Map<String, dynamic>> artFamousList = [
  {
    "artId": 1,
    "artName": "Girl with a Pearl Earring",
    "imageUrl": "assets/Famous/Image1.jpg",
    "painter": "Johannes Vermeer",
    "origin": "Netherlands",
    "description": "Young girl in the painting gazes over her shoulder.",
    "minBidPrice": 25000,
    "currentBidPrice": 25000,
    "reviews": [
      {
        "reviewId": 1,
        "userId": 1001,
        "review": "Beautiful artwork, the colors are so vibrant!",
        "rating": 5,
      },
      {
        "reviewId": 2,
        "userId": 1002,
        "review": "Good piece, but the frame quality could be better.",
        "rating": 4,
      },
    ],
    "stock": 5,
  },
  {
    "artId": 2,
    "artName": "The Starry Night",
    "imageUrl": "assets/Famous/Image2.jpg",
    "painter": "Vincent Van Gogh",
    "origin": "France",
    "description":
        "Captures a dramatic night sky swirling with vibrant blues, yellows, and white tones.",
    "minBidPrice": 31000,
    "currentBidPrice": 31000,
    "reviews": [
      {
        "reviewId": 3,
        "userId": 1003,
        "review": "A fascinating composition of abstract ideas!",
        "rating": 5,
      },
      {
        "reviewId": 4,
        "userId": 1004,
        "review": "A bit too abstract for my taste, but still high quality.",
        "rating": 3,
      },
    ],
    "stock": 6,
  },
  {
    "artId": 3,
    "artName": "Prague Courtyard",
    "imageUrl": "assets/Famous/Image3.jpg",
    "painter": "Alexander Klemens ",
    "origin": "Czech Republic",
    "description":
        "An enclosed or semi-enclosed open space surrounded by buildings.",
    "minBidPrice": 20400,
    "currentBidPrice": 20400,
    "reviews": [
      {
        "reviewId": 5,
        "userId": 1005,
        "review": "Perfect for my living room!",
        "rating": 5
      }
    ],
    "stock": 4,
  },
  {
    "artId": 4,
    "artName": "Mona Lisa",
    "imageUrl": "assets/Famous/Image4.jpg",
    "painter": "Leonardo Da Vinci",
    "origin": "Paris",
    "description": "A woman with an enigmatic expression.",
    "minBidPrice": 50000,
    "currentBidPrice": 50000,
    "reviews": [
      {
        "reviewId": 6,
        "userId": 1006,
        "review": "The lights feel so real!",
        "rating": 5
      },
      {"reviewId": 7, "userId": 1007, "review": "Amazing piece!", "rating": 4}
    ],
    "stock": 2,
  },
  {
    "artId": 5,
    "artName": "Death Playing the Fiddle",
    "imageUrl": "assets/Famous/Image5.jpg",
    "painter": "Arnold Böcklin",
    "origin": "Australia",
    "description": "Death is often depicted as a skeletal figure.",
    "minBidPrice": 45000,
    "currentBidPrice": 45000,
    "reviews": [
      {
        "reviewId": 8,
        "userId": 1008,
        "review": "Brings a sense of calm.",
        "rating": 5
      }
    ],
    "stock": 7,
  },
];

List<FamousDataModel> famous = artFamousList
    .map((e) => FamousDataModel.toMap(
          data: e,
        ))
    .toList();

List<Map<String, dynamic>> artHotsList = [
  {
    "artId": 1,
    "artName": "Impression Sunrise",
    "imageUrl": "assets/Hots/Image1.jpg",
    "painter": "Claude Monet ",
    "origin": "Paris",
    "description": "A misty harbor at sunrise in the port of Le Havre.",
    "minBidPrice": 13500,
    "currentBidPrice": 13500,
    "reviews": [
      {
        "reviewId": 9,
        "userId": 1009,
        "review": "It feels like a warm summer day!",
        "rating": 5
      }
    ],
    "stock": 10,
  },
  {
    "artId": 2,
    "artName": "The Scream",
    "imageUrl": "assets/Hots/Image2.jpg",
    "painter": "Edvard Munch",
    "origin": "Norway",
    "description":
        "A distorted, androgynous figure standing on a bridge, clutching its head with both hands.",
    "minBidPrice": 27700,
    "currentBidPrice": 27700,
    "reviews": [
      {
        "reviewId": 10,
        "userId": 1010,
        "review": "Powerful and energetic!",
        "rating": 5
      },
    ],
    "stock": 11,
  },
  {
    "artId": 3,
    "artName": "White Roses",
    "imageUrl": "assets/Hots/Image3.jpg",
    "painter": "Margaretha Roosenboom",
    "origin": "Dutch",
    "description":
        "White roses are characterized by their delicate beauty and realism.",
    "minBidPrice": 26000,
    "currentBidPrice": 26000,
    "reviews": [
      {
        "reviewId": 11,
        "userId": 1011,
        "review": "The colors of fall are so well captured!",
        "rating": 5
      },
    ],
    "stock": 8,
  },
  {
    "artId": 4,
    "artName": "Desert Mirage",
    "imageUrl": "assets/Hots/Image4.jpg",
    "painter": "Ahmed Ali",
    "origin": "Egypt",
    "description": "A hot desert scene with a distant mirage on the horizon.",
    "minBidPrice": 13000,
    "currentBidPrice": 13000,
    "reviews": [
      {
        "reviewId": 12,
        "userId": 1012,
        "review": "Mysterious and beautiful.",
        "rating": 4
      },
    ],
    "stock": 5,
  },
  {
    "artId": 5,
    "artName": "Dawn in the Seaside",
    "imageUrl": "assets/Hots/Image5.jpg",
    "painter": "Alireza",
    "origin": "Japan",
    "description":
        "A typical scene of dawn by the seaside captures the soft, early light of the morning.",
    "minBidPrice": 15000,
    "currentBidPrice": 15000,
    "reviews": [
      {
        "reviewId": 13,
        "userId": 1013,
        "review": "A dreamlike experience.",
        "rating": 5
      },
    ],
    "stock": 17,
  },
];

List hots = artHotsList
    .map(
      (e) => HotsDataModel.toMap(
        data: e,
      ),
    )
    .toList();

List<Map<String, dynamic>> artHouseHoldsList = [
  {
    "artId": 1,
    "artName": "Custom Cat Portrait",
    "imageUrl": "assets/HouseHolds/Image1.jpg",
    "painter": "Anya Petrova",
    "origin": "Russia",
    "description": "A solitary figure reflecting by a cat.",
    "minBidPrice": 1400,
    "currentBidPrice": 1400,
    "reviews": [
      {
        "reviewId": 14,
        "userId": 1014,
        "review": "Quiet and meditative.",
        "rating": 5
      },
    ],
    "stock": 21,
  },
  {
    "artId": 2,
    "artName": "Women Oil Pastel",
    "imageUrl": "assets/HouseHolds/Image2.jpg",
    "painter": "Lars Bjornson",
    "origin": "Norway",
    "description": "Highlight the graceful curves and forms of a woman's body",
    "minBidPrice": 1900,
    "currentBidPrice": 1900,
    "reviews": [
      {
        "reviewId": 15,
        "userId": 1015,
        "review": "The colors are incredible!",
        "rating": 5
      },
    ],
    "stock": 18,
  },
  {
    "artId": 3,
    "artName": "Summer Picnic",
    "imageUrl": "assets/HouseHolds/Image3.jpg",
    "painter": "Marie Dubois",
    "origin": "France",
    "description": "A peaceful summer picnic in a lush garden.",
    "minBidPrice": 600,
    "currentBidPrice": 600,
    "reviews": [
      {
        "reviewId": 16,
        "userId": 1016,
        "review": "So relaxing to look at.",
        "rating": 5
      },
    ],
    "stock": 9,
  },
  {
    "artId": 4,
    "artName": "Sunset Garden",
    "imageUrl": "assets/HouseHolds/Image4.jpg",
    "painter": "Rajesh Gupta",
    "origin": "India",
    "description": "Morning sunlight filtering through the dense forest.",
    "minBidPrice": 400,
    "currentBidPrice": 400,
    "reviews": [
      {
        "reviewId": 17,
        "userId": 1017,
        "review": "Feels like you're there.",
        "rating": 5
      },
    ],
    "stock": 16,
  },
  {
    "artId": 5,
    "artName": "Warship",
    "imageUrl": "assets/HouseHolds/Image5.jpg",
    "painter": "Emma Zhang",
    "origin": "China",
    "description":
        "A starry night sky full of bright stars and a clear moonlight.",
    "minBidPrice": 550,
    "currentBidPrice": 550,
    "reviews": [
      {
        "reviewId": 18,
        "userId": 1018,
        "review": "A mesmerizing night sky.",
        "rating": 5
      },
      {
        "reviewId": 19,
        "userId": 1019,
        "review": "Perfect for my bedroom.",
        "rating": 4
      },
    ],
    "stock": 26,
  },
];

List households = artHouseHoldsList
    .map(
      (e) => HouseHoldsDataModel.toMap(
        data: e,
      ),
    )
    .toList();
