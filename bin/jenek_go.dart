void main(List<String> arguments) {
  const taskNumber = 3;
  switch (taskNumber) {
    case 1:
      task1(); // ✅
    case 2:
      task2();
    case 3:
      task3();
    case 4:
      task4(); // ✅
    case 5:
      task5();
    default:
      print('No task with $taskNumber number. Provide task number from 1 to 5');
  }
}

void task1() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];

  print('$list');
}

void task2() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  List<int> reversedList = list.reversed.toList();
  print('Вот развернул туда сюда; $reversedList');

  // Solution without using .reversed
}

void task3() {
  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  List<int> evenNumbers = list.where((number) => number.isEven).toList();

  print(evenNumbers);

  // Solution without .where and .isEven
}

void task4() {
  List<int> list = List.from([0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55]);
  List<int> skipList = [];
  for (int i = 0; i < list.length; i += 2) {
    skipList.add(list[i]);
  }
  print(skipList);
}

void task5() {
  /*
  решение неверное, числа должны выводиться ПОКА НЕ встретится -1. Т.е. когда 
  оно встречается, то уже не должно быть его вывода.
  решение плохое, так как жестко завязано на текущем массиве.
  Если поменять массив на другой, где 10 не стояло бы за -1, то программа
  бы отработала неверно. Такого быть не должно. Программа должна всегда
  выдавать верный результат вне зависимости от входных данных.

  Для более точной проверки своего решения используй для теста следующие массивы
  (помимо изначального):
      - [5, 3, -10, -1, 0, 2]
      - [5234, 1234, -2, -1, 3489, 432, -124, 12345, -12345]
      - [10, 10, -10, 1, -1]
  */

  List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  int stopElement = 10;
  List<int> result = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] == stopElement) {
      break;
    }
    result.add(list[i]);
  }

  print(result);
}
