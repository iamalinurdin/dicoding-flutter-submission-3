import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class AddReview extends StatefulWidget {
  static const routeName = '/add_review';
  final Restaurant restaurant;

  const AddReview({super.key, required this.restaurant});
  
  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Add Review'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your review is useful for ${widget.restaurant.name}, give the best review.',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your name',
                    filled: true,
                    fillColor: const Color.fromARGB(23, 74, 98, 163),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      // borderSide: BorderSide.none
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _reviewController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Review',
                    filled: true,
                    fillColor: const Color.fromARGB(23, 74, 98, 163),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      // borderSide: BorderSide.none
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white
                    )
                  ),
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final payload = {
                        'id': widget.restaurant.id,
                        'name': _nameController.text,
                        'review': _reviewController.text
                      };

                      final request  = await http.post(Uri.parse('https://restaurant-api.dicoding.dev/review'), body: payload);
                      final response = jsonDecode(request.body);

                      if (response['error'] == false) {
                        _nameController.clear();
                        _reviewController.clear();

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Review successfully saved.'),
                            action: SnackBarAction(
                              label: 'Back', 
                              onPressed: () {
                                Navigator.pop(context);
                              }
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Save Review'),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}