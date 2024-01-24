// import 'dart:math';

import 'dart:math';

void main() {
  task3();
  /*
  Здарова. Здесь мы будем учить булеаны. Булеан – это тип данных в языке Dart.
  Записывается булеан в дарте как bool. Бул может хранить все всего два
  значения – true или false. Истина или ложь. Чтобы создать и инициализорвать новую
  булеву переменную используй следующую запись: bool iAmGay = false; <- не
  забывай про точку с запятой!

  Булеаны нужны в программировании, когда мы хотим хранить в переменной некое
  двоичное состояние, когда есть все два варианта ответа: 1 или 0, истина или
  ложь. Примерами таких переменных могу быть:
      bool passedExam = true (true если ты уже сдавал ЕГЭ, false если еще нет)
      bool girl = false (true если женщина, false если мужчина)
      bool isEqual = x == y; (true если значение переменной х равно значению
      переменной y)

  Также, булеаны часто встречаются в известных уже нам операторах сравнения:
      x > y -> такой выражение возвращает bool
      x == y также возвращает bool.

  При использовании условного оператора if:
      bool randomBool = false;

      if (randomBool) { // <-- здесь мы напрямую кладем переменную типа bool
        doSomething();
      } else {
        doAnother();
      }
-
      ––––––––––––––––––––––––
      final x = 2;
      final y = 5;
      
      if (x > y) { // <-- здесь мы уже задаем не конкретную переменную типа bool, а кладем выражение, возвращающее bool
        print('x is greater than y');
      } else {
        print('y is greater than x');
      }


      Помимо if оператора, bool используется также и в циклах while, for:

      while (true) { <-- бесконечный цикл, так как каждую итерацию цикл будет проверять: true == true?
        doSomething();
      }

      for (int i = 0; i < 10; i++) { <-- второй параметр требует, чтобы мы вернули bool, по которому цикл и понимает, при каком условии запускать следующую итерацию или завершить выполнение цикла.
        doSomething();
      }


      Также булы жизненно необходимо в алгебре логики, так как результат любого
      логического выражения всегда будет true или false.

      Конечно, было бы круто, если бы ты самостоятельно изучил основы алгебры
      логики и порешал задачи на это. Здесь же я расскажу только про два оператора: логическое И и логическое ИЛИ.

      При логическом И выражение возвращает true, когда выражение А и выражение В также true.
      При логическом ИЛИ выражение true, когда хотя бы одно из двух выражений true.
      Логическое И принято записывать как &&, а логическое ИЛИ как ||.

      A = true;
      B = true;
      A && B = true;
      A || B = true;

      A = true;
      B = false;
      A && B = false; <-- для логического И важно, чтобы оба значения были true
      A || B = true;  <-- для логического ИЛИ достаточно, чтобы хотя бы одно значение было true

      A = false;
      B = false;
      A && B = false;
      A || B = false;

      Также в алгебре логики есть оператор отрицания – НЕ, в записи языка Dart
      мы записываем ! перед выражением\* или переменной, возвращающими bool. Например:
      bool a = true;
      print(a); <-- печатается true;
      print(!a); <-- печатается false;

      Понаблюдай как изменятся результаты логических выражений с использованием НЕ:
      A = true;
      B = true;
      A && !B = false;
      !A && B = false;
      !A || B = true;
      A || !B = true;

      Для чего нам это в проганьи??? Мы применяем булы и алгебрку логики в программировании
      когда хотим выполнить какие-то операции в зависимости от МНОЖЕСТВА условий и их вариаций.
       Просто приведу пример кода:

      final isGay = false;
      final isMale = true;

      if (isMale && isGay) { // заметь мы не пишем if (isMale == true && isGay == true), запись if (isMale) это тоже самое, что if (isMale == true).
        print('Зачмырить');
      }
      if (isMale && !isGay) {
        print('проявить уважение');
      }
      if (!isMale && isGay) {
        print('удалиться из группы');
      }
      if (!isMale && !isGay) {
        print('предложить встречаться');
      }

      Для закрепления материала предлагается решить следующие задачи:
      task1(),
      task2(),
      task3(),
  */
}

void task1() {
  /*
  Даются переменные x,y,rnd.
  Нужно напечатать в консоль '1', если rnd больше, чем y
  Напечатать '2', если rnd лежит между x и y.
  Напечатать '3', если rnd лежит перед х.
  */

  int y = Random().nextInt(10);
  int x = Random().nextInt(10);
  int rnd = Random().nextInt(10);
  print('y=$y, x=$x, rnd=$rnd');
  if (rnd > y) {
    print(1);
    if (rnd < x) {
      print('2\n3');
    }
  } else if (rnd != y && rnd > x) {
    print(2);
  } else if (rnd < x) {
    print(3);
  } else {
    print('x <= y && (x == rnd || y == rnd)');
  }
}

void task2() {
  /*
  Создай массив со всеми цветами светофора. Пройдись 4 раза по всему массиву, и
  выведи в консоль true, когда водителю можно ехать, и false когда ехать нельзя.
  */
  final a = <String>['Red', 'Yellow', 'Green'];
  int r;
  for (int i = 0; i < 16; i++) {
    r = i % 4;
    print(a[r < 3 ? r : 1] == 'Green');
  }
}

void task2Jeka() {
  const redLight = 'Red';
  const yellowLight = 'Yellow';
  const greenLight = 'Green';

  final trafficLights = <String>[redLight, yellowLight, greenLight];

  String? previousLight;
  for (int i = 0; i < 3; i++) {
    for (final light in trafficLights) {
      print('Previous Light: $previousLight');
      print('Current Light: $light');
      print(light != redLight ||
          (light == yellowLight && previousLight == redLight));
      previousLight = light;
    }
  }
}

void task3() {
  /*
  Тебя попросили написать программу, которую мы бы установили на аппарат на складе,
  отвечающий за сортировку продуктов. Программа, должна вычислять, какой продукт
  подается и распределять его в соответствующий магазин. В конце программа должна
  вывести в консоль количество продуктов в каждом магазине после распределения.
  */
  final products = [
    Product.potato,
    Product.apple,
    Product.orange,
    Product.apple,
    Product.tomato,
    Product.apple,
    Product.potato,
    Product.apple,
    Product.potato,
    Product.tomato,
    Product.potato,
    Product.orange,
  ];
  final fruitStore = <Product>[];
  final vegetableStore = <Product>[];

  for (var product in products) {
    if (product == Product.apple || product == Product.orange) {
      fruitStore.add(product);
    } else if (product == Product.potato || product == Product.tomato) {
      vegetableStore.add(product);
    }
  }
  print("${fruitStore.length} ${vegetableStore.length}");
}

enum Product { apple, orange, tomato, potato }
