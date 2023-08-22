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

  // создаем экземпляр класса Shape
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

  // Реши задачу task1
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

class Human {
  String name;
  Gender gen;
  int age;
  Human? relationship;

  Human(this.name, this.age, this.gen);

  void greet() {
    print('привет, $name');
  }

  void startRelationships(Human otherHuman) {
    if (gen != otherHuman.gen && relationship == null) {
      print(' $name начал отношения s  ${otherHuman.name}');
      relationship = otherHuman;
      otherHuman.relationship = this;
    } else {
      if (gen == otherHuman.gen) {
        print('${otherHuman.name} is gay');
      } else {
        print('извините ${otherHuman.name} уже состоит в отношениях');
      }
    }
  }

  void endRelationships() {
    if (relationship != null) {
      print('$name разорвал отношения');
    } else {
      print('$name не состоит в отношения');
    }
    relationship?.relationship = null;
    relationship = null;
  }
}

void task1() {
  var human1 = Human('Bob', 29, Gender.male);
  var human2 = Human('Any', 27, Gender.female);
  var human3 = Human('Brody', 27, Gender.male);
  var human4 = Human('Dabby', 24, Gender.female);
  human1.greet();
  human2.greet();
  human3.greet();

  human1.startRelationships(human2);
  human1.endRelationships();
  human2.endRelationships();
  human4.greet();
  human3.startRelationships(human4);
  human3.endRelationships();

  human3.startRelationships(human1);
  human1.startRelationships(human3);
}

enum Gender {
  male,
  female;
}

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
