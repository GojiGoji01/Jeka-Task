import 'package:jenek_go/jenek_go.dart' as jenek_go;

void main(List<String> arguments) {
  // 11111
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55 ];

  // print('$list');
// 222222
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  // List<int> reversedList = list.reversed.toList();
  // print('Вот развернул туда сюда; $reversedList');
  ///333333
  ///
  // List<int> list = [0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55];
  // List<int> evenNumbers = list.where((number) => number.isEven).toList();

  // print(evenNumbers);

  //////444444444
  ///
  // List<int> list = List.from([0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55]);
  // List<int> skipList = [];
  // for (int i = 0; i < list.length; i += 2) {
  //   skipList.add(list[i]);
  // }
  // print(skipList);

  List<int> list = List.from([0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55]);
  int stopElement = -1;
  List<int> result = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] == stopElement) {
      break;
    }
    result.add(list[i]);
  }

  print(result);
}
