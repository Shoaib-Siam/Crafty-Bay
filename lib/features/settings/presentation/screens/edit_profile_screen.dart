import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/controller/auth_controller.dart';
import '../../../auth/data/models/update_profile_request_model.dart';
import '../../../auth/presentations/controllers/update_profile_controller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';

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
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Inject the controller
  final UpdateProfileController _updateProfileController = Get.put(
    UpdateProfileController(),
  );

  @override
  void initState() {
    super.initState();
    // PRE-FILL DATA FROM SAVED AUTH CONTROLLER
    final userData = AuthController.userData;

    if (userData != null) {
      _emailTEController.text = userData.email ?? '';
      _firstNameTEController.text = userData.firstName ?? '';
      _lastNameTEController.text = userData.lastName ?? '';
      _mobileTEController.text = userData.phone ?? '';
      _cityTEController.text = userData.city ?? '';
    }
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
              _buildPhotoPicker(),
              const SizedBox(height: 32),

              TextFormField(
                controller: _emailTEController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email Address',
                  suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                  filled: true,
                ),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _firstNameTEController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    (value?.trim().isEmpty ?? true) ? 'Enter first name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _lastNameTEController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    (value?.trim().isEmpty ?? true) ? 'Enter last name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _mobileTEController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile'),
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? 'Enter mobile number'
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _cityTEController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) =>
                    (value?.trim().isEmpty ?? true) ? 'Enter city' : null,
              ),

              const SizedBox(height: 32),

              // UPDATE BUTTON WITH LOADING STATE
              GetBuilder<UpdateProfileController>(
                builder: (controller) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !controller.inProgress,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: FilledButton(
                        onPressed: _updateProfile,
                        child: const Text('Update'),
                      ),
                    ),
                  );
                },
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
          backgroundImage: const NetworkImage(
            "https://i.pravatar.cc/150?u=a042581f4e29026704d",
          ),
          onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 50),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              // Photo picker logic requires image_picker package
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // 1. Create the Model
      UpdateProfileRequestModel model = UpdateProfileRequestModel(
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        phone: _mobileTEController.text.trim(),
        city: _cityTEController.text.trim(),
      );

      // 2. Call the Controller
      final bool result = await _updateProfileController.updateProfile(model);

      // 3. Handle Success
      if (result && mounted) {
        showSnackBarMessage('Success', 'Profile updated successfully');
        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}
