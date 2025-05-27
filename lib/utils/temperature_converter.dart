/// Convert temperature based on selected conversion type
double convertTemperature(double inputValue, bool isFToC) {
  if (isFToC) {
    // °C = (°F - 32) x 5/9
    return (inputValue - 32) * 5 / 9;
  } else {
    // °F = °C x 9/5 + 32
    return inputValue * 9 / 5 + 32;
  }
}
