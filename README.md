# Temperature Converter App

A Flutter application that provides a user-friendly interface for converting temperatures between Fahrenheit and Celsius. The app features a clean, responsive design that works in both portrait and landscape orientations.

## Features

- Convert temperatures between Fahrenheit and Celsius
- Real-time conversion history tracking
- Responsive design for both portrait and landscape orientations
- Input validation and error handling
- Clean, modern UI with intuitive controls

## Architecture

The app follows a modular architecture with clear separation of concerns:

```
lib/
├── main.dart                 # Application entry point
├── screens/                  # Screen widgets
│   └── temperature_converter_screen.dart
├── widgets/                  # Reusable UI components
│   ├── conversion_selector.dart
│   ├── temperature_section.dart
│   └── conversion_history_section.dart
├── models/                   # Data models
│   └── conversion_history.dart
└── utils/                    # Utility functions
    └── temperature_converter.dart
```

### Key Components

1. **TemperatureConverterScreen**: Main screen that manages the app's state and layout
2. **ConversionSelector**: Widget for toggling between F→C and C→F conversions
3. **TemperatureSection**: Input/output display for temperature values
4. **ConversionHistorySection**: Displays the history of recent conversions
5. **TemperatureConverter**: Utility class handling the conversion logic

## Getting Started

1. Ensure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Usage

1. Select the conversion type (Fahrenheit to Celsius or Celsius to Fahrenheit)
2. Enter a temperature value in the input field
3. Press the "CONVERT" button to see the result
4. View your conversion history below the converter

## Temperature Conversion Logic

The app uses the following formulas for temperature conversion:

- Fahrenheit to Celsius: °C = (°F - 32) × 5/9
- Celsius to Fahrenheit: °F = (°C × 9/5) + 32

## Contributing

Feel free to submit issues and enhancement requests!
