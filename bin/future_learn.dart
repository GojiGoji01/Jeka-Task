Future<void> main() async {
  // bool isHardLevel = true;
  // if (isHardLevel) {
  //   _hardExample();
  // } else {
  //   _explanation();
  // }
  _explanation();
}

// <––––––––––––––––––––––––– FOUNDATION EXAMPLE –––––––––––––––––––––––––>

Future<void> _explanation() async {
  /* Если мы хотим отловить ошибку во Future, который мы раскрываем через .then,
  то мы также можешь вызвать .catchError((error) {
    ..some code
  });
  */
  loadGreetings('Jeka').then((value) => print(value)).catchError((error) {
    print(error);
  });

  loadGreetings('Different Name')
      .then((value) => print(value))
      .catchError((error) {
    print(error);
  });

  /* Тут вроде бы все понятно. А что же с await? Покажу тот же самый пример,
  но с использованием await
*/
  final jekaGreetings = await loadGreetings(
      'Jeka'); // когда мы используем await не может быть никаких .then, .catchError
  print(jekaGreetings);

  try {
    /*
    Когда мы работаем с await и хотим отловить возможные эксепшны с future,
    то мы должны обернуть код в блок try-catch
     */
    final smbGreetings = await loadGreetings('smb');
    print(smbGreetings);
  } catch (e) {
    /* Этот блок кода выполняется, когда await фьючера обломался и выкинуло
    эксепшн
    */
    print(e);
  }
}

Future<String> loadGreetings(String name) async {
  if (name != 'George' && name != 'Jeka') {
    throw Exception('Unknown human-being');
  }
  return '$name, waddup!';
}

// <––––––––––––––––––––––––– HARD EXAMPLE –––––––––––––––––––––––––>
final class UndefinedWeightCategory implements Exception {
  const UndefinedWeightCategory(this.user);

  final User user;

  @override
  String toString() {
    return 'Cannot define weight category of user: \n$user';
  }
}

Future<void> _hardExample() async {
  final normaldo = FatUser(name: 'Normaldo', age: 17);
  final jeka = SkinnyUser(name: 'Normaldo', age: 17);

  final testUser = TestUser(name: 'Kirill', age: 25);

  try {
    final normaldoPrice = await loadProgramPrice(normaldo);
    print('Normaldo program price: $normaldoPrice');
    final jekaPrice = await loadProgramPrice(jeka);
    print('Jeka program price: $jekaPrice');
    final testPrice = await loadProgramPrice(testUser);
    print('Test User price: $testPrice');
  } on UndefinedWeightCategory catch (e) {
    print('\n$e');
  } catch (e) {
    print('Unknown Error: $e');
  }
}

Future<double> loadProgramPrice(User user) async {
  const programDurationInDays = 30;
  var fatMultiplier = 0;
  if (user is SkinnyUser) {
    fatMultiplier = 50;
  }
  if (user is FatUser) {
    fatMultiplier = 100;
  }

  if (user is! SkinnyUser && user is! FatUser) {
    throw UndefinedWeightCategory(user);
  }

  return (user.age * fatMultiplier * programDurationInDays).toDouble();
}

abstract base class User {
  User(this.name, this.age);

  final String name;
  final int age;

  @override
  String toString() {
    return 'Name: $name\nAge: $age';
  }
}

final class SkinnyUser extends User {
  SkinnyUser({
    required String name,
    required int age,
  }) : super(name, age);
}

final class FatUser extends User {
  FatUser({
    required String name,
    required int age,
  }) : super(name, age);
}

final class TestUser extends User {
  TestUser({
    required String name,
    required int age,
  }) : super(name, age);
}

// <––––––––––––––––––––––––– PHILLIPS TASKS –––––––––––––––––––––––––>

Future<void> task1() async {
  /*
  Скопируй свой код из classes.dart сюда и перепеши, заменив принты на throw, 
  пробрасывая какие-то экспешены и обрабатывая их. Сделай функции startRelationship
  и stopRelationship фьючерами и добавь делэй для того, чтобы они успели познакомиться
  друг с другом) Попробуй вызывать эти функции обоими способами (.then и await),
  и также используй соответсвующие обработчики ошибок для них.
  */
}
