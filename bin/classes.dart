import 'dart:math';

void main() {
  task1();
  /*
  Классы - это шаблоны объектов, содержащих в себе поля (переменные) и методы (функции).
  Классы это база в объектно-ориентированном программировании (ООП). ООП характеризуется
  3мя основными принципами:
    1. Наследование – позволяет наследовать классы, создавая дочерний класс.
    Такой класс заимствует все поля и методы родительского класса, позволяя 
    расширить функционал родительского класса, добавив туда уникальные методы и поля.
    2. Инкапсуляция – также известное как сокрытие данных. Данный принцип отвечает
    за то, какие поля и методы должны быть скрыты для внешнего интерфейса (то есть
    вне самого класса), а какие открыты.
    3. Полиморфизм – данный принцип дословно переводится как "много форм" и 
    позволяет нам переопределять методы родительского класса для определения
    новой "формы" данного метода.

    Рассмотрим класс Shape.
  */

  /*// создаем экземпляр класса Shape
  final squaredShape = Shape(sidesCount: 4, area: 16);
  print(
      '${squaredShape.runtimeType}: sides – ${squaredShape.sidesCount}, area – ${squaredShape.area}');

  // Теперь изучи класс Square
  final sqr1 = Square(area: 30);
  print('${sqr1.runtimeType}: area – ${sqr1.area}, sides – ${sqr1.sidesCount}');
  // Также у Square мы создали доп. поле sideSize, так как мы можем вычислить
  // сторону квадрата, зная его площадь.
  print(sqr1.sideSize);
  // При этом у родительского класса такого поля нет.

  // Теперь изучи Triangle
  final triangle = Triangle(area: 10);
  print(
      '${triangle.runtimeType}: area – ${triangle.area}, sides – ${triangle.sidesCount}');

  // Реши задачу task1*/
}

/// классы в дарте всегда определяются вне всяких функций
class Shape {
  /// кол-во сторон
  final int sidesCount;

  /// площадь фигуры
  final double area;

  /*
    * Конструктор класса Shape, который позволяет нам при создании экземпляра 
    * класса задать значения для наших final констант.
    */
  Shape({
    required this.sidesCount,
    required this.area,
  });
}

/// extends означает расширяем (ну или наследуем) класс Shape, те перенимаем все
/// его поля и методы.
class Square extends Shape {
  /// через super. мы можем сразу указать, что данный параметр это параметр,
  /// требуемый родительским классом в его конструкторе. Все дочерние классы
  /// обязаны так или иначе инициализировать родительские поля.
  ///
  /// Через super() мы можем инициализировать родительские поля.
  /// Данный конструктор можно прочитать так:
  /// конструктор класса Квадрат с обязательным именованным параметром площадь,
  /// который также инициализирует родительский sidesCount значением 4, так как
  /// в квадрате всегда 4 стороны без исключений.
  Square({required super.area}) : super(sidesCount: 4);

  /// @override означает что следующая переменная или метод переопределены из
  /// родительского класса. В данном случае мы создали класс Квадрат, а в нем,
  /// как известно, всегда 4 стороны без исключений.
  ///

  /// get - это геттер переменной, то есть он только возвращает какое-то значение,
  /// но никогда не позволит нам записать в него новое, допустим через:
  /// final sqr = Square(area: 16);
  /// sqr.sideSize = 10; <--- компилятор выдаст ошибку, так как sideSize это
  /// геттер.
  double get sideSize => sqrt(area); // sqrt(x) - функция, выдающая квадратный
  // корень из x.
}

class Triangle extends Shape {
  Triangle(
      {required super.area,
      this.isEquilateral =
          false /*необязательный параметр, 
  но если мы его не укажем, то установится дефолтное значение */
      })
      : super(sidesCount: 3);

  final bool isEquilateral;
}

void task1() {
  /*
  Необходимо создать класс Человек с параметрами: имя, пол, возраст, и методами:
  поприветствовать, который будет выводить в консоль Привет, [Имя другого человека]!.

  Также создать функцию "начать отношения", параметром принимающая другого человека и 
  проверяющая его пол и наличие других отношений. Если пол противоположен и у другого
  человека нет отношений, то начать отношения с этим человеком, в противном случае вывести
  в консоль причину отказа (пол или наличие отношений).

  Также создать функцию "разорвать отношения", которая разрывает текущие отношения,
  если таковые имеются. 
   */
  var male = Human('Игорь', Sex.male, 18);
  var female = Human('Наташа', Sex.female, 28);

  // JEKA: – создаю такую переменную и отправляю ее в stopRelationship
  // код крашнется, подумай почему и поправь
  var another = 123;
  male.stopRelationship(another);

  male.salutation(female);
  male.stopRelationship(female);
}

class Human {
  // JEKA: – нужно указывать явно тип, иначе я могу в эти три поля положить
  // переменные любого типа и все функции крашнутся
  final name;
  final sex;
  final age;

  // JEKA: – Не ошибка, но линтер жалуется, тк необязательно nullable переменную
  // инитить null'ом. Если написать Human? someHuman; -> это тоже самое, она
  // по умолчанию будет null;
  Human? relationshipStatus = null;

  Human(this.name, this.sex, this.age);

  void salutation(Human another) {
    print('Привет, ${another.name}!');
  }

  void stopRelationship(var another) {
    if (relationshipStatus == another) {
      relationshipStatus = null;
      another.relationshipStatus = null;
      print('$name и ${another.name} расстались!');
    } else {
      print('$name и ${another.name} не состоят в отношениях!');
    }
  }

  void startRelationship(Human another) {
    if (another.relationshipStatus == null &&
        relationshipStatus == null &&
        another.sex != sex) {
      relationshipStatus = another;
      another.relationshipStatus = this;
      print('$name и ${another.name} вступают в отношения!');
    } else if (another.relationshipStatus != null) {
      print('${another.name} уже состоит в отношениях!');
      // JEKA: – опять лишний this. Настрой пж линтер
    } else if (this.relationshipStatus != null) {
      print('$name уже состоит в отношениях!');
    } else if (another.sex == sex) {
      print(
          '$name и ${another.name} не могут состоять в отношениях, они одного пола!');
    }
  }
}

enum Sex { male, female }
