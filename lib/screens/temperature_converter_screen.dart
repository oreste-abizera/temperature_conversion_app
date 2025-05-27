import 'package:flutter/material.dart';
import '../models/conversion_history.dart';
import '../utils/temperature_converter.dart';
import '../widgets/conversion_selector.dart';
import '../widgets/temperature_section.dart';
import '../widgets/conversion_history_section.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  bool _isFahrenheitToCelsius = true;
  double? _convertedValue;
  List<ConversionHistory> _conversionHistory = [];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _handleConversion() {
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a temperature value')),
      );
      return;
    }

    final inputValue = double.tryParse(_inputController.text);
    if (inputValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }

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
