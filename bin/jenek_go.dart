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

  // List<int> list = List.from([0, 1, 3, 4, 5, 2, 1, -4, -1, 10, 55]);
  // int stopElement = 10;
  // List<int> result = [];

  // for (int i = 0; i < list.length; i++) {
  //   if (list[i] == stopElement) {
  //     break;
  //   }
  //   result.add(list[i]);
  // }

  // print(result);

//   List<int> list = List.from([0, 2, 3, 4, 5, 6, 7, -1]);
//   int stopElement = -1;
//   List<int> result = [];
//   for (int i = 0; i < list.length; i++) {
//     if (list[i] == stopElement) {
//       break;
//     }
//     result.add(list[i]);
//   }
//   print(result);
// }
// List<int> result = [];

// result.add(34);
// result.add(35);
// result.add(36);
// result.add(37);

// print(result);
//   List<int> list = List.from([1, 5, 6, 8, 9, 0, 2]);
//   int stopElement = 2;
//   List<int> result = [];

//   for (int i = 0; i < list.length; i++) {
//     if (list[i] == stopElement) {
//       break;
//     }
//     result.add(list[i]);
//   }
//   print(result);
// }
  List<int> list = List.from([
    4,
    10,
    45,
    67,
    78,
    -3,
  ]);
  int stopElement = 78;
  List<int> result = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] == stopElement) {
      break;
    }
    result.add(list[i]);
  }

  print(result);
}
