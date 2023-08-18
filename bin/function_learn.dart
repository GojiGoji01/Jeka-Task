void main() {
  task1();
}

double kmToMiles(double km) {
  const kmToMileConv = 0.631130;
  return km * kmToMileConv;
}

void task1() {
  double km1 = 10;
  double km2 = 20;
  double km3 = 30;
  double km4 = 40;
  double km5 = 50;

  print('$km1 км = ${kmToMiles(km1)} миль');
  print('$km2 км = ${kmToMiles(km2)}миль');
  print('$km3 км = ${kmToMiles(km3)}миль');
  print('$km4 км = ${kmToMiles(km4)}миль');
  print('$km5 км = ${kmToMiles(km5)}миль');
}



// void task1() {
//   /* Создать функцию getCount, которая возвращает целое число, а принимает в себя
//   список String. Функция должна считать кол-во элементов в списке и возвращать
//   это кол-во. Не забудь, что функция лишь возращает значение, но не печатает его.
//   После вызова не забудь сделать принт полученного результата.
// */
//   //  String concatenateStrings(String str1, String str2) {}
//   int getCount(List<String> list) {
//     return list.length;
//   }

//   print(getCount);
// }

// void task2() {
//   // /**
//   //  * Создать функцию, которая будет сращивать две строки в одну и возвращать
//   //  * полученную строку.
//   //  */
//   String concatenateStrings(String str1, String str2) {
//     return str1 + str2;
//   }
// }

// void task3() {
//   double convertKmtoMiles(double km) {
//     const kmInMile = 0.621371;
//     return km * kmInMile;
//   }
// }

// void task4() {
//   double convertMilestoKm(double mile) {
//     const mileInKm = 1;
//     return mile / mileInKm;
//   }
// }

// class Kmnamili {
//   int km;
//   double mile;

//   Kmnamili(this.km, this.mile);

//   makeDrobule() {
//     return km / mile;
//   }
// }

// void task5() {
//   var itog = Kmnamili(1, 0.630134);
//   print(itog.makeDrobule());
// }

// void task10() {
//   final listOfChar = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
//   // for (var index = 0; index < 6; index++) {
//   var i = 0;
//   for (final element in listOfChar) {
//     print('${++i} $element');
//   }

//   // print('$index: ${listOfChar[i]}');
// }


/* 
имя 
фамилия
отчество
паспорт серия и номер
возраст 
зарплату по месяцам
*/