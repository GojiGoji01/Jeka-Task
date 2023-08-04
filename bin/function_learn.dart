void main() {
  /**
   * Функция - это блок кода, который будет выполнен при вызове самой функции.
   * Dart функции записываются как:
   * type name(parameters) {
   *    // block of code
   * }
   * где type - это тип возвращаемого значения. Это означает, что после выполне-
   * ния функция вернет значения типа type. Если тип возвращаемого значения НЕ
   * void, то функция всегда должна заканчиваться return value;, где value – 
   * переменная типа type;
   * name - название функции, по которому мы будем в дальнейшем к ней обращать-
   * ся.
   * parameters - всегда указываются в круглых скобках после названия функции.
   * Параметры можно указывать через запятую, например:
   * int getCount(List<String> names) {}
   * String concatenateStrings(String str1, String str2) {}
   * 
   * Как видим, данные функции должны возвращать int и String соответственно. По
   * названиям функции и параметрам должно быть понятно, что они сделают и что
   * вернут.
   * 
   * Функции используются для того, чтобы не плодить одинаковый код. Приведу 
   * пример:
   * нужно написать прогу, которая выводит можно ли ехать в зависимости от сигна
   * ла светофора.
   */
  // инициализируем массив со всему возможными цветами светофора.

  String currentLight = 'green';
  switch (currentLight) {
    case 'green':
      print('Можно ехать');
    case 'red':
      print('Ехать нельзя!');
    default:
      print('Я не знаю можно ли ехать((');
  }

  currentLight = 'red';

  switch (currentLight) {
    case 'green':
      print('Можно ехать');
    case 'red':
      print('Ехать нельзя!');
    default:
      print('Я не знаю можно ли ехать((');
  }

  currentLight = 'green';

  switch (currentLight) {
    case 'green':
      print('Можно ехать');
    case 'red':
      print('Ехать нельзя!');
    default:
      print('Я не знаю можно ли ехать((');
  }

  print(
      '<––––––––––––––––––––––––– Конец первого решения –––––––––––––––––––––––––>');

  /* Программа работает верно, но сколько же нам придется раз копировать этот
  свич, если у нас большой проект, связанный с управлением городскими светофорами?
  Предполагаю, что очень много.. А что случится, если новенький программист 
  случайно в одном из свичей поменяет значение? Все рухнет и будет непонятно почему.

  Для этого программисты и используют функции, чтобы отделить код, который может
  понадобиться нам не один раз в отдельную функцию. Преобразим задачу, используя
  функции.
  */

  print(
      '<––––––––––––––––––––––––– Преображаем функцией –––––––––––––––––––––––––>');

  void printTrafficLightsState(String light) {
    /* void - это такой же тип, как int, bool или String. Void отвечает за пустоту,
    то есть такая функция что-то делает, но ничего не должна возвращать (то есть
    ей не нужен return), хотя мы можем написать return; что будет означать команду
    "закончить функцию немедленно!"

    printTrafficLightsState - название функции
    (String light) - означает, что при вызове функции ты обязан "сдать" функции
    одну переменную типы String, которая ВНУТРИ функции будет иметь имя light
    */

    // здесь мы свичим light из параметра, так как хотим реагировать именно на
    // входное данное
    switch (light) {
      case 'green':
        print('Можно ехать');
      case 'red':
        print('Ехать нельзя!');
      default:
        print('Я не знаю можно ли ехать((');
    }
  }

  currentLight = 'green';
  printTrafficLightsState(currentLight);

  currentLight = 'red';
  printTrafficLightsState(currentLight);

  currentLight = 'yellow';
  printTrafficLightsState(currentLight);

  print(
      '<––––––––––––––––––––––––– Конец преображения –––––––––––––––––––––––––>');

  /*
  Обрати внимание, как преобразился код визуально, это благодаря функциям,
  используй их с умом.

  Приведу также пример с функциями, которые возвращают значение, как они
  работают и как их можно применять. Я лишь опишу пример, попробуй понять его сам.
  */

  print(
      '<––––––––––––––––––––––––– Функции, возвращающие значение –––––––––––––––––––––––––>');

  int multiply(int num1, int num2) {
    return num1 * num2;
  }

  String convertToString(Object o) {
    return '$o';
  }

  bool checkIfValid(String input) {
    // если сработает return то остальной код уже не выполнится, так как
    // функция завершит свое выполнение.
    if (input.contains('гавна')) return false;
    if (input.contains('сволочь')) return false;
    if (input.contains('гнида')) return false;
    if (input.contains('сабака')) return false;

    // соответсвенно true вернется тогда, когда все предыдущие if условия будут false.
    return true;
  }

  print(multiply(10, 20));
  print(convertToString(12938457.213451234));
  final isGnidaValid = checkIfValid('гнида');
  print(isGnidaValid);
  print(checkIfValid('красава'));

  /**
   * Надеюсь, тебе что-то стало понятнее, хотя если честно я совсем в это не верю..
   * Тем не менее попробуй решить таски.
   */
}

void task1() {
  /* Создать функцию getCount, которая возвращает целое число, а принимает в себя
  список String. Функция должна считать кол-во элементов в списке и возвращать
  это кол-во. Не забудь, что функция лишь возращает значение, но не печатает его.
  После вызова не забудь сделать принт полученного результата.
*/
  //  String concatenateStrings(String str1, String str2) {}
}

void task2() {
  /**
   * Создать функцию, которая будет сращивать две строки в одну и возвращать 
   * полученную строку.
   */
}
