Future<void> main() async {
  loadGeorge().then((value) => print(value));
  final name = await loadJeka();
  print(name);
}

Future<String> loadGeorge() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'George';
}

Future<String> loadJeka() async {
  await Future.delayed(Duration(milliseconds: 105));
  return 'Jeka';
}
