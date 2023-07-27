void main() {
  task5();
}

void task2() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  var reversedList = <int>[];

  for (int i = list.length - 1; i >= 0; i--) {
    reversedList.add(list[i]);
  }

  print(reversedList);
}

void task3() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  var onlyEven = <int>[];

  for (var e in list) {
    if (e % 2 == 0) {
      onlyEven.add(e);
    }
  }

  print(onlyEven);
}

void task5() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];

  for (final e in list) {
    if (e == -1) break;
    print(e);
  }
}
