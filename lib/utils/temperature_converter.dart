/// Utility class for temperature conversion operations.
///
/// This class provides methods to convert temperatures between
/// Fahrenheit and Celsius using standard conversion formulas:
/// - F to C: °C = (°F - 32) × 5/9
/// - C to F: °F = (°C × 9/5) + 32

/// Converts a temperature value between Fahrenheit and Celsius.
///
/// [inputValue] The temperature value to convert
/// [isFToC] If true, converts from Fahrenheit to Celsius; if false, converts from Celsius to Fahrenheit
/// Returns the converted temperature value as a double
double convertTemperature(double inputValue, bool isFToC) {
  if (isFToC) {
    // Convert Fahrenheit to Celsius using the formula: °C = (°F - 32) × 5/9
    return (inputValue - 32) * 5 / 9;
  } else {
    // Convert Celsius to Fahrenheit using the formula: °F = (°C × 9/5) + 32
    return inputValue * 9 / 5 + 32;
  }
}
