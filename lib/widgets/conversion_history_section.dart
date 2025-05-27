import 'package:flutter/material.dart';
import '../models/conversion_history.dart';

class ConversionHistorySection extends StatelessWidget {
  final List<ConversionHistory> history;

  const ConversionHistorySection({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'History:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: history.isEmpty
              ? const Center(
                  child: Text(
                    'No conversions yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final entry = history[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        entry.displayText,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
