import 'dart:io';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Variables to hold user information
  String userName = "John Doe";
  String email = "john.doe@example.com";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        ? FileImage(File(imagePath))
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
                Center(
                  child: ElevatedButton(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
