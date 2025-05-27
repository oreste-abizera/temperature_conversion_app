import 'package:flutter/material.dart';
import '../models/conversion_history.dart';
import '../utils/temperature_converter.dart';
import '../widgets/conversion_selector.dart';
import '../widgets/temperature_section.dart';
import '../widgets/conversion_history_section.dart';

/// The main screen of the Temperature Converter app.
///
/// This screen manages the state of the temperature conversion process and
/// provides a responsive layout that adapts to both portrait and landscape
/// orientations. It handles:
/// - User input validation
/// - Temperature conversion
/// - Conversion history tracking
/// - Layout management
class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  // Controller for the input text field
  final TextEditingController _inputController = TextEditingController();

  // Tracks the current conversion direction (F→C or C→F)
  bool _isFahrenheitToCelsius = true;

  // Stores the most recent conversion result
  double? _convertedValue;

  // Maintains the history of all conversions
  List<ConversionHistory> _conversionHistory = [];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// Handles the temperature conversion process.
  ///
  /// This method:
  /// 1. Validates the input value
  /// 2. Performs the conversion
  /// 3. Updates the conversion history
  /// 4. Updates the UI state
  void _handleConversion() {
    // Validate empty input
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a temperature value')),
      );
      return;
    }

    // Validate numeric input
    final inputValue = double.tryParse(_inputController.text);
    if (inputValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }

    // Perform conversion and update history
    final convertedValue =
        convertTemperature(inputValue, _isFahrenheitToCelsius);
    final historyEntry = ConversionHistory(
      type: _isFahrenheitToCelsius ? 'F to C' : 'C to F',
      inputValue: inputValue,
      outputValue: convertedValue,
    );

    setState(() {
      _convertedValue = convertedValue;
      _conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      // Use OrientationBuilder to create responsive layouts
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout();
          } else {
            return _buildLandscapeLayout();
          }
        },
      ),
    );
  }

  /// Builds the portrait layout of the app.
  ///
  /// This layout arranges components vertically:
  /// - Conversion selector at the top
  /// - Temperature input/output in the middle
  /// - Convert button below
  /// - History section at the bottom
  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConversionSelector(
            isFahrenheitToCelsius: _isFahrenheitToCelsius,
            onChanged: (value) {
              setState(() {
                _isFahrenheitToCelsius = value;
                _convertedValue = null;
              });
            },
          ),
          const SizedBox(height: 20),
          TemperatureSection(
            inputController: _inputController,
            convertedValue: _convertedValue,
            onInputChanged: () {
              if (_convertedValue != null) {
                setState(() {
                  _convertedValue = null;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleConversion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'CONVERT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ConversionHistorySection(history: _conversionHistory),
          ),
        ],
      ),
    );
  }

  /// Builds the landscape layout of the app.
  ///
  /// This layout arranges components horizontally:
  /// - Conversion controls on the left
  /// - History section on the right
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConversionSelector(
                  isFahrenheitToCelsius: _isFahrenheitToCelsius,
                  onChanged: (value) {
                    setState(() {
                      _isFahrenheitToCelsius = value;
                      _convertedValue = null;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TemperatureSection(
                  inputController: _inputController,
                  convertedValue: _convertedValue,
                  onInputChanged: () {
                    if (_convertedValue != null) {
                      setState(() {
                        _convertedValue = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleConversion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'CONVERT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: ConversionHistorySection(history: _conversionHistory),
          ),
        ],
      ),
    );
  }
}
