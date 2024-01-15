void main(List<String> arguments) {
  const taskNumber = 5;

  switch (taskNumber) {
    case 1:
      task1();
    case 2:
      task2();
    case 3:
      task3();
    case 4:
      task4();
    case 5:
      task5();
    default:
      print('No task with $taskNumber number. Provide task number from 1 to 5');
  }
}

final a = <int>[1, 2, 3, -1, 4, 5];

void task1() {
  // Выводит все элементы массива.
  a.forEach(spacedPrint);
}

void task2() {
  // Выводит все элементы массива в обратном порядке.
  a.reversed.forEach(spacedPrint);
}

void task3() {
  // Выводит чётные элементы массива.
  a.forEach((element) {
    if (!element.isOdd) spacedPrint(element);
  });
  // a
  //     .where((e) => e % 2 == 0)
  //     .forEach(print);
}

void task4() {
  // Выводит все элементы массива через 1.
  for (int i = 0; i < a.length; i += 2) {
    spacedPrint(a[i]);
  }
  // bool flag = true;
  // a.forEach((element) {
  //   if (flag) print(element);
  //   flag = !flag;
  // });
}

void task5() {
  // Выводит все элементы массива пока не встретится элемент -1.
  for (int i = 0; i < a.length && a[i] != -1; i++) {
    spacedPrint(a[i]);
  }
}

void spacedPrint(int value) => print('$value ');
