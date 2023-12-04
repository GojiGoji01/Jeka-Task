void main(List<String> arguments) {
  const isJeka = false;
  const taskNumber = 3;

  switch (taskNumber) {
    case 1:
      if (isJeka) return task1Jeka();
      task1();
    case 2:
      if (isJeka) return task2Jeka();
      task2();
    case 3:
      if (isJeka) return task3Jeka();
      task3();
    case 4:
      task4();
    case 5:
      task5();
    default:
      print('No task with $taskNumber number. Provide task number from 1 to 5');
  }
}

void task1() {
  // Выводит все элементы массива.
  List massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  /*Map   massive = {
    'thirst' : 'thirst',
    'Second' : 'Second'
  };*/
  // Iterator iterator = (massive as Iterator<dynamic>);

  for (var i in massive){
    print(i);
  }
}

void task1Jeka() {
  // Выводит все элементы массива.
  final randomArray = [0, 123, 54, 2345, 543, 123, 654, 124];

  for (final item in randomArray) {
    print(item);
  }
}

void task2() {
  // Выводит все элементы массива в обратном порядке.
  List massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int iterator = massive.length;

  while (--iterator >= 0) {
    print(massive[iterator]);
  }
}

void task2Jeka() {
  // Выводит все элементы массива в обратном порядке.
  final randomArray = [0, 123, 54, 2345, 543, 123, 654, 124];

  for (int i = randomArray.length - 1; i >= 0; i--) {
    print(randomArray[i]);
  }
}

void task3() {
  // Выводит чётные элементы массива.
  List array = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int iterator = -1;

  while (++iterator < array.length) {
    if (array[iterator] % 2 == 0) {
      print(array[iterator]);
    }
  }
}

void task3Jeka() {
  // Выводит чётные элементы массива.
  final array = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  for (final number in array) {
    if (number % 2 == 0) print(number);
  }
}

void task4() {
  // Выводит все элементы массива через 1.
  List array = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  for (int i = 0; i < array.length; i++){
    if (i % 2 == 1) print(array[i]);
  }
}

void task5() {
  // Выводит все элементы массива пока не встретится элемент -1.
  List array = [1, 2, 3, 4, 5, 6, -1, 7, 8, 9];
  
  for (final i in array){
    if (i == -1)
      break;
    else
      print(i);
  }
}
