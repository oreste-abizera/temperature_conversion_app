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
            decoration: InputDecoration(
              hintText: 'Enter temperature',
              prefixIcon: const Icon(Icons.thermostat_outlined),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            onChanged: (_) => onInputChanged(),
          ),
        ),

        // Equals sign with animation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              '=',
              key: ValueKey<double?>(convertedValue),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),

        // Result display with animation
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: convertedValue != null
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: convertedValue != null
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                convertedValue?.toStringAsFixed(1) ?? '',
                key: ValueKey<double?>(convertedValue),
                style: TextStyle(
                  fontSize: 18,
                  color: convertedValue != null
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  fontWeight: convertedValue != null
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
