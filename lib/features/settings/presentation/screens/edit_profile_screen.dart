import 'package:flutter/material.dart';
// Ensure you have this or use a placeholder

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // TODO: Prefill with existing user data from your Controller/Cache
    _emailTEController.text = "tanvir@gmail.com";
    _firstNameTEController.text = "Tanvir";
    _lastNameTEController.text = "Ahmed";
    _mobileTEController.text = "01712345678";
    _addressTEController.text = "Dhaka, Bangladesh";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // 1. Profile Photo Picker
              _buildPhotoPicker(),

              const SizedBox(height: 32),

              // 2. Form Fields
              TextFormField(
                controller: _emailTEController,
                readOnly: true, // Email is usually not editable
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email Address',
                  suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                  // Grey out the background to show it's disabled
                  filled: true,
                ),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _firstNameTEController,
                decoration: const InputDecoration(labelText: 'First Name', hintText: 'First Name'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Enter first name';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _lastNameTEController,
                decoration: const InputDecoration(labelText: 'Last Name', hintText: 'Last Name'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Enter last name';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _mobileTEController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile', hintText: 'Mobile Number'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Enter mobile number';
                  // Add regex validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressTEController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Shipping Address',
                  hintText: 'Enter your full address',
                  alignLabelWithHint: true, // Aligns label to top for text area
                ),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Enter address';
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // 3. Update Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _updateProfile,
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade200,
          // Replace with NetworkImage if user has one
          backgroundImage: const NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026704d"),
          onBackgroundImageError: (_,__) => const Icon(Icons.person, size: 50),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              // TODO: Open Image Picker (Gallery/Camera)
              print("Pick Image");
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Call API to update profile
      print("Update Profile: ${_firstNameTEController.text}");
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}