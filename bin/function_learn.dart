void main() {
  task1();

  /**
   * Функции в дарте имеют вид:
   * String toString(int num) {
   * ...
   * }
   * где String - это тип возвращаемого значения. Означает, что функцию не
   * может завершиться в любом из своих возможных концов без возвращения пере-
   * менной типа String. Такой возврат осуществляется ключевым словом return,
   * например:
   * final str = 'Some String';
   * return str;
   * ИЛИ
   * return 'Some String';
   * 
   * toString  - название функции по которой мы можем ее вызывать,
   * (int num) - список параметров, передаваемых функции при ее вызове. Задают-
   * ся в круглых скобках сразу после названия функции через запятую в формате:
   * тип название
   * {} –> далее задаются фигурные скобки, определяющие блок кода, выполняемый
   * функцией
   */
}

void task1() {
  /* Создать функцию getCount, которая возвращает целое число, а принимает в себя
  список String. Функция должна считать кол-во элементов в списке и возвращать
  это кол-во. Не забудь, что функция лишь возращает значение, но не печатает его.
  После вызова не забудь сделать принт полученного результата.

  Функцию можешь создать в файле либо прямо внутри этой функции
*/
  print(getCount(['lol', 'kek', 'meme', 'future']));
}

int getCount(List<String> ls)
{
  return (ls.length);
}

void task2() {
  // /**
  //  * Создать функцию, которая будет сращивать две строки в одну и возвращать
  //  * полученную строку.
  // Функцию можешь создать в файле либо прямо внутри этой функции
  //  */
  print(mergeString('kek', 'lol'));
}

String  mergeString(String s1, String s2)
{
  return (s1 + s2);
}

void task3() {
  /*
  Создать функицю, которая принимает в себя целое число, а возвращает список
  целых чисел с 0 до входного числа.
  */
  print(integerTo(6));
}

List<int> integerTo(int integer)
{
  List<int>  listOfInteger = [];

  for (int i = 0; i < integer; i++){
    listOfInteger.add(i);
  }

  return (listOfInteger);
}

void task4() {
  /**
   * Создать функцию, которая распечатывает тип значения, переданного параметром.
   * Для определения переменной динамического типа можно использовать тип dynamic.
   * Например, dynamic something.
   * Также, чтобы узнать тип переменной в ходе выполнения программы можно исполь
   * зовать геттер runtimeType. Такой геттер присущ всем переменным, наследующим
   * класс Object (то есть всем абсолютно, так как в дарте все классы унаследованы
   * от Object)
   * 
   * Формат вывода: 
   * 10.27 has a type of double
   * Sokrat has a type of String
   */
  printType(1.1);
}

void  printType(dynamic something)
{
  print('$something has a type of ${something.runtimeType}');
}
