Future<void> main() async {
  loadGeorge().then((value) => print(value));
  final name = await loadJeka();
  print(name);
}

Future<String> loadGeorge() async {
  return 'George';
}

Future<String> loadJeka() async {
  return 'Jeka';
}
