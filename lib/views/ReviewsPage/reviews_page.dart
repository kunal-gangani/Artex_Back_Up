import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/globals/art_data.dart';

class ArtReviewsPage extends StatefulWidget {
  const ArtReviewsPage({super.key});

  @override
  _ArtReviewsPageState createState() => _ArtReviewsPageState();
}

class _ArtReviewsPageState extends State<ArtReviewsPage> {
  // Controllers for user input
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _reviewDescriptionController =
      TextEditingController();
  String _selectedArtName = "";
  double _selectedRating = 0.0;

  // Show dialog for user to input review details
  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a Review"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for Art Name selection
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Art Name',
                  ),
                  value: _selectedArtName.isEmpty ? null : _selectedArtName,
                  items: combinedArtList
                      .map((art) => DropdownMenuItem<String>(
                            value: art['artName'],
                            child: Text(art['artName']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedArtName = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Text field for User Name
                TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                  ),
                ),
                const SizedBox(height: 12),
                // Rating Bar
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _selectedRating = rating;
                  },
                ),
                const SizedBox(height: 12),
                // Text field for Review Description
                TextField(
                  controller: _reviewDescriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Review Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              onPressed: () {
                // Clear input and close dialog
                _clearInputFields();
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_selectedArtName.isNotEmpty &&
                    _userNameController.text.isNotEmpty &&
                    _selectedRating > 0 &&
                    _reviewDescriptionController.text.isNotEmpty) {
                  // Add review to the selected art
                  _addReviewToArt();
                  // Clear input and close dialog
                  _clearInputFields();
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                "Submit",
              ),
            ),
          ],
        );
      },
    );
  }

  // Clear input fields
  void _clearInputFields() {
    _userNameController.clear();
    _reviewDescriptionController.clear();
    _selectedRating = 0.0;
    _selectedArtName = "";
  }

  // Add review to the specific art item
  void _addReviewToArt() {
    final newReview = {
      'userId': _userNameController.text,
      'rating': _selectedRating,
      'review': _reviewDescriptionController.text,
    };

    setState(() {
      // Find the art in the combined list and add the review
      for (var art in combinedArtList) {
        if (art['artName'] == _selectedArtName) {
          if (art['reviews'] != null) {
            art['reviews'].add(newReview);
          } else {
            art['reviews'] = [newReview];
          }
          break;
        }
      }
    });
  }

  // Combined art list
  List<Map<String, dynamic>> get combinedArtList => [
        ...artFamousList,
        ...artHotsList,
        ...artHouseHoldsList,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: combinedArtList.length,
          itemBuilder: (context, index) {
            final art = combinedArtList[index];
            final reviews = art['reviews'] as List<dynamic>;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Artwork Image and Name
                    Row(
                      children: [
                        Image.asset(
                          art['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          art['artName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    // Painter and Description
                    Text(
                      "Painter: ${art['painter']}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      art['description'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Reviews Section
                    Text(
                      "Reviews:",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    // List of reviews for the specific artwork
                    ...reviews.map((review) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User ID and Rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "User ID: ${review['userId']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  // Display Rating
                                  RatingBarIndicator(
                                    rating: review['rating']?.toDouble() ?? 0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              // Review Text
                              Text(
                                review['review'],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showReviewDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
