String rewriteDateLancamento({required DateTime data}) {
  return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} às ${data.hour}:${data.minute}';
}
