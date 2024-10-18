import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minor_project/helper/auth_helper.dart';
import 'package:minor_project/helper/fcm_helper.dart';
import 'package:minor_project/views/RegisterPage/register_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Variables to hold user information
  String userName = "abc";
  String email = "abc@gmail.com";
  String bio = "Art lover and collector.";
  String imagePath = "";

  // Text editing controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Variable to control edit mode
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with current user information
    nameController.text = userName;
    emailController.text = email;
    bioController.text = bio;
  }

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        imagePath = image.path; // Update image path
      });
    }
  }

  // Function to save updated information
  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        userName = nameController.text;
        email = emailController.text;
        bio = bioController.text;
        isEditing = false; // Lock editing mode
      });
      // You can add additional code to save this data to a database or API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Profile updated successfully!",
          ),
        ),
      );
    }
  }

  // Function to handle user logout
  void handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text(
            'Do you really wish to log out of your account? This action will end your current session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel action
            child: const Text('Dismiss'),
          ),
          TextButton(
            onPressed: () async {
              await AuthHelper.authHelper.logOut();
              // Implement your logout functionality here.
              Flexify.goRemoveAll(RegisterPage()); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("You have been logged out successfully."),
                ),
              );
              // Additional logout logic can be added here if needed, such as redirecting to the login screen.
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FCMHelper.fcmHelper.fetchCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;

            Map<String, dynamic>? currentData = data?.data() ?? {};

            nameController.text = currentData['name'];
            emailController.text = currentData['email'];
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: CircleAvatar(
                          radius: 50.w,
                          backgroundImage: imagePath.isNotEmpty
                              ? FileImage(
                                  File(
                                    imagePath,
                                  ),
                                )
                              : const AssetImage(
                                  'assets/default_avatar.jpg',
                                ) as ImageProvider,
                          child: imagePath.isEmpty
                              ? const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : null, // No icon if image is present
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        readOnly:
                            !isEditing, // Make field editable only when in edit mode
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        readOnly:
                            !isEditing, // Make field editable only when in edit mode
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: bioController,
                        decoration: const InputDecoration(
                          labelText: "Bio",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        readOnly:
                            !isEditing, // Make field editable only when in edit mode
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your bio';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isEditing) {
                                  saveProfile(); // Save profile if in editing mode
                                } else {
                                  isEditing = true; // Enable editing mode
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 24.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: Text(
                              isEditing ? "Save Details" : "Edit Profile",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ElevatedButton(
                            onPressed: handleLogout, // Call the logout function
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 24.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Log Out button
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
