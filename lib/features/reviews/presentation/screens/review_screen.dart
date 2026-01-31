import 'package:crafty_bay/features/reviews/presentation/screens/create_review_screen.dart';
import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/bottom_section_container.dart';
import '../widgets/review_card_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String routeName = '/reviews';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Dummy Data for UI
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Rabbil Hasan',
      'date': '20 Jan 2026',
      'rating': 4.5,
      'text':
          'The product quality is amazing! I really liked the packaging and the delivery was super fast. Highly recommended.',
    },
    {
      'name': 'Tanvir Ahmed',
      'date': '18 Jan 2026',
      'rating': 5.0,
      'text': 'Perfect fit and the material feels premium. Will order again.',
    },
    {
      'name': 'John Doe',
      'date': '15 Jan 2026',
      'rating': 3.0,
      'text':
          'Good product but the color is slightly different from the picture.',
    },
    {
      'name': 'Sarah Smith',
      'date': '10 Jan 2026',
      'rating': 4.0,
      'text': 'Comfortable shoes, good value for money.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          // 1. Scrollable List of Reviews
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewCardWidget(
                  userName: reviews[index]['name'],
                  reviewDate: reviews[index]['date'],
                  rating: reviews[index]['rating'],
                  reviewText: reviews[index]['text'],
                );
              },
            ),
          ),

          // 2. Bottom Section: "Reviews (Count)" + "Add Button"
          _buildAddReviewSection(context),
        ],
      ),
    );
  }

  // ... inside your ReviewScreen class

  Widget _buildAddReviewSection(BuildContext context) {
    // USE THE GENERIC CONTAINER
    return BottomSectionContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reviews (${reviews.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  const Text(
                    '4.8',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                ],
              ),
            ],
          ),

          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateReviewScreen.routeName);
            },
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
