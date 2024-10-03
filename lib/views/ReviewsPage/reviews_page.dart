import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  // Sample data for reviews. Replace this with your own inbuilt map data.
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "John Doe",
      "rating": 4.5,
      "review":
          "Amazing artwork! The details are exceptional, and the colors are vibrant.",
      "date": "Sep 28, 2024"
    },
    {
      "name": "Jane Smith",
      "rating": 5.0,
      "review":
          "Absolutely loved it! The texture and design are one-of-a-kind.",
      "date": "Oct 1, 2024"
    },
    {
      "name": "Robert Brown",
      "rating": 3.8,
      "review": "Nice art, but the size was smaller than expected.",
      "date": "Oct 3, 2024"
    },
  ];

  // Controller variables for input fields in dialog box.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  double userRating = 0.0;

  // Function to add a new review to the list.
  void addReview(String name, double rating, String review) {
    setState(() {
      reviews.add({
        "name": name,
        "rating": rating,
        "review": review,
        "date": DateTime.now().toLocal().toString().split(' ')[0],
      });
    });
  }

  // Function to show the review submission dialog box.
  void showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Add Your Review",
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your name",
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                RatingBar.builder(
                  initialRating: 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    userRating = rating;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(
                    labelText: "Review",
                    hintText: "Write your review",
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
              ),
            ),
            TextButton(
              onPressed: () {
                // Check for empty inputs before adding the review.
                if (nameController.text.isNotEmpty &&
                    reviewController.text.isNotEmpty &&
                    userRating > 0) {
                  addReview(
                    nameController.text,
                    userRating,
                    reviewController.text,
                  );
                  // Show toastification for successful review submission.
                  toastification.show(
                    context: context,
                    title: const Text(
                      "Review Submitted!",
                    ),
                    description: const Text(
                      "Your review has been added successfully.",
                    ),
                    backgroundColor: Colors.green,
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  );
                  nameController.clear();
                  reviewController.clear();
                  userRating = 0.0;
                  Navigator.pop(context);
                } else {
                  // Show toastification for empty fields.
                  toastification.show(
                    context: context,
                    title: const Text(
                      "Incomplete Fields",
                    ),
                    description: const Text(
                      "Please enter all fields and provide a rating.",
                    ),
                    backgroundColor: Colors.red,
                    icon: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];

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
                    // Username and Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['name'] ?? "Anonymous",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          review['date'] ?? "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    // Rating Bar
                    RatingBarIndicator(
                      rating: review['rating'] ?? 0.0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    // Review Text
                    Text(
                      review['review'] ?? "No review text provided.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showReviewDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
