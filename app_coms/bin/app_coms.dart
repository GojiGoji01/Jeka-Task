import 'dart:math';

import 'dart:collection';

import 'package:collection/collection.dart';

enum Color {
  Red,
  Green,
  Blue,
}

class Shape {
  double get square => 0.0;
  final Color color;
  Shape(this.color);
}

class Rectangle extends Shape {
  final int sideA;
  final int sideB;
  final int sideC;

  @override
  double get square => (sideA * sideB * sideC).toDouble();

  Rectangle(
    Color color,
    this.sideA,
    this.sideB,
    this.sideC,
  ) : super(color);
}

class Circle extends Shape {
  final int radius;
  @override
  double get square => pi * radius * radius;

  Circle(
    Color color,
    this.radius,
  ) : super(color);
}

class Square extends Shape {
  final int side;

  @override
  double get square => side * side.toDouble();

  Square(
    Color color,
    this.side,
  ) : super(color);

  // int sideA() {
  //   return sideA();
  // }
}

// Square(int side) // после двоиточия свойства пошли
//     : lenght = side,
//       weight = side;

// // КОНСТРУКТОР^^^^^^^
// Square.wrong(this.lenght, this.weight);

void main() {
  final shape = Shape(Color.Blue);
  final rectangle = Rectangle(Color.Green, 10, 3, 90);
  final circle = Circle(Color.Red, 6);
  final square = Square(Color.Blue, 9);

  print(rectangle.color);
  print(rectangle.square);

  print(circle.color);
  print(circle.square);

  print(square.color);
  print(square.square);

  print(shape.color);
  print(shape.square);
  // square.sideA();
}
  // final one = Employe(
  //   'Ivan',
  //   'Ivanov',
  //   '0133 030049',
  //   45,
  //   [1000, 1500, 2000, 1000, 3000, 2000, 1000, 2000, 2000, 2000, 1500],
  //   6,
  // );


/*
имя
фамилия 
отчество
паспорт серия и номер
возраст 
зарплату по месяцам
*/
/*
Не в классе   | В классе

функция       =  метод - функция внутри класса  (особенность: имеет переменную this которая указывает на объект у которого был вызван метод )
переменная    = свойство
*/
/*
Создай класс пацанов которые плавают в бассеине . один проплыл больше чем другой , выведи их в консоль
их результат  
*/
// class Pacani {
//   final String name;
//   final int age;
//   final List<int> meters;
//   final int? lenght;

//   Pacani(this.name, this.age, this.meters, this.lenght);

//   int allMeters() {
//     if (meters.isEmpty) {
//       return 0;
//     }
//     return meters.reduce((value, element) => value + element);
//   }

//   @override
//   String toString() {
//     return 'name: $name\nage: $age\nmeters: $meters';
//   }
// }

// void task1() {
//   final one = Pacani(
//     'Jeka',
//     24,
//     [100, 100, 200, 100, 300, 200, 500],
//     4,
//   );

//   final two = Pacani(
//     'Goji',
//     28,
//     [50, 50, 50, 100, 200, 200, 400],
//     4,
//   );

//   final resultOne = one.allMeters();
//   final resultTwo = two.allMeters();

//   print('${one.name}: $resultOne');
//   print('${two.name}: $resultTwo');
//   final difference = resultOne - resultTwo;
//   print('$difference');
// }
