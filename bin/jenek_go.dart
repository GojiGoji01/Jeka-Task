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

void task1() {
  // Выводит все элементы массива.
  List  massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  /*Map   massive = {
    'thirst' : 'thirst',
    'Second' : 'Second'
  };*/
  int   iterator = -1;
 // Iterator iterator = (massive as Iterator<dynamic>);
  

  while(++iterator < (massive.length)){
    print(massive[iterator]);
  }
}

void task2() {
  // Выводит все элементы массива в обратном порядке.
  List  massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int   iterator = massive.length;

  while(--iterator >= 1){
    print(massive[iterator]);
  }
}

void task3() {
  // Выводит чётные элементы массива.
  List  massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int   iterator = -1;

  while(++iterator < massive.length){
    if ((iterator + 1) % 2 == 0){
      print(massive[iterator]);
    }
  }
}

void task4() {
  // Выводит все элементы массива через 1.
  List  massive = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int   iterator = -1;

  while(++iterator < massive.length){
    if ((iterator + 1) % 2 == 1){
      print(massive[iterator]);
    }
  }
}

void task5() {
  // Выводит все элементы массива пока не встретится элемент -1.
  List  massive = [1, 2, 3, 4, 5, 6, -1, 7, 8, 9];
  int   iterator = -1;

  while(++iterator < massive.length && massive[iterator] != -1){
    print(massive[iterator]);
    //iterator++;
  }
}
