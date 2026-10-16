class AppFormatters {
  AppFormatters._();

  static String currency(num amount) {
    final rounded = amount.round().toString();
    final buffer = StringBuffer();

    for (var i = 0; i < rounded.length; i++) {
      if (i > 0 && (rounded.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(rounded[i]);
    }

    return 'Rp$buffer';
  }
}
