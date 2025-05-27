import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureSection extends StatelessWidget {
  final TextEditingController inputController;
  final double? convertedValue;
  final VoidCallback onInputChanged;

  const TemperatureSection({
    Key? key,
    required this.inputController,
    required this.convertedValue,
    required this.onInputChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input field
        Expanded(
          child: TextField(
            controller: inputController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            onChanged: (_) => onInputChanged(),
          ),
        ),

        // Equals sign
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '=',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // Result display
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.grey.shade100,
            ),
            child: Text(
              convertedValue?.toStringAsFixed(2) ?? '',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
