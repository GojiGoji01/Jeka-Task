void main(List<String> arguments) {
  // 11111 ✅
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];

  // print('$list');
// 222222  -> в целом ок, но сделай еще одно решение этой задачи
// без использования .reversed.
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  // List<int> reversedList = list.reversed.toList();
  // print('Вот развернул туда сюда; $reversedList');

  // /333333 -> сделай решение без использования .where и .isEven
  // /
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  // List<int> evenNumbers = list.where((number) => number.isEven).toList();

  // print(evenNumbers);

  //////444444444 ✅
  ///
  // List<int> list = List.from([0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55]);
  // List<int> skipList = [];
  // for (int i = 0; i < list.length; i += 2) {
  //   skipList.add(list[i]);
  // }
  // print(skipList);

  // TASK 5
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
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  // int stopElement = 10;
  // List<int> result = [];

  // for (int i = 0; i < list.length; i++) {
  //   if (list[i] == stopElement) {
  //     break;
  //   }
  //   result.add(list[i]);
  // }

  // print(result);

//   List<int> list = List.from([0, 2, 3, 4, 5, 6, 7, -1]);
//   int stopElement = -1;
//   List<int> result = [];
//   for (int i = 0; i < list.length; i++) {
//     if (list[i] == stopElement) {
//       break;
//     }
//     result.add(list[i]);
//   }
//   print(result);
// }
// List<int> result = [];

// result.add(34);
// result.add(35);
// result.add(36);
// result.add(37);

// print(result);
  // List<int> list = List.from([1, 5, 6, 8, 9, 0, 2]);
  // int stopElement = 2;
  // List<int> result = [];

  // for (int i = 0; i < list.length; i++) {
  //   if (list[i] == stopElement) {
  //     break;
  //   }
  //   result.add(list[i]);
  // }
  // print(result);
}
