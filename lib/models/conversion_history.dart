class ConversionHistory {
  final String type;
  final double inputValue;
  final double outputValue;

  ConversionHistory({
    required this.type,
    required this.inputValue,
    required this.outputValue,
  });

  /// Format the conversion history entry for display
  String get displayText {
    if (type == 'F to C') {
      return 'F to C: ${inputValue.toStringAsFixed(1)} ⇒ ${outputValue.toStringAsFixed(1)}';
    } else {
      return 'C to F: ${inputValue.toStringAsFixed(1)} ⇒ ${outputValue.toStringAsFixed(1)}';
    }
  }
}
