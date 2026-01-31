import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  static const String routeName = '/create-review';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Track selected rating (default 0)
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Review'),
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
              const SizedBox(height: 30),

              // 1. First & Last Name Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      validator: Validators.validateFirstName,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      validator: Validators.validateLastName,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 2. Star Rating Selector
              Text(
                'How would you rate this product?',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              _buildStarRatingSelector(),

              const SizedBox(height: 30),

              // 3. Review Text Field
              TextFormField(
                controller: _reviewController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'Write your review here...',
                  contentPadding: EdgeInsets.all(16),
                ),
                validator: Validators.validateReview,
              ),

              const SizedBox(height: 40),

              // 4. Submit Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _onSubmit,
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Star Selector Widget
  Widget _buildStarRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
          icon: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            size: 40,
            color: Colors.amber, // Classic star color
          ),
        );
      }),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedRating == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a star rating')),
        );
        return;
      }

      // TODO: Call API to submit review
      print("Review Submitted: Rating $_selectedRating");
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
