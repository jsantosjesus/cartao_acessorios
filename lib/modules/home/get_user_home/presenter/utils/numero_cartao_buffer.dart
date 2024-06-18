String numeroCartaoBuffer({required String numero}) {
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < numero.length; i++) {
    if (i > 0 && i % 4 == 0) {
      buffer.write(' ');
    }
    buffer.write(numero[i]);
  }
  return buffer.toString();
}
