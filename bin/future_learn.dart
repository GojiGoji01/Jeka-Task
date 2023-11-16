// import 'dart:js';

import 'dart:collection';
import 'dart:ffi';

Future<void> main() async {
  // bool isHardLevel = true;
  // if (isHardLevel) {
  //   _hardExample();
  // } else {
  //   _explanation();
  // }
  task1();
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

// <––––––––––––––––––––––––– KIRILL TASKS –––––––––––––––––––––––––>

final class StartRelationshipException implements Exception {
  // не понимаю для чего тут надо использовать ключевое слово "final"
  const StartRelationshipException(this.human1, this.human2);
  // не понимаю для чего тут надо использовать ключевое слово "const"

  final Human human1;
  final Human human2;

  @override
  String toString() => '${human1.name} и ${human2.name} начали встречаться!';
}

final class AlreadyStartedRelationshipException implements Exception {
  const AlreadyStartedRelationshipException(this.human);

  final Human human;

  @override
  String toString() => 'К сожалению ${human.name} уже состоит в отношениях!';
}

final class SameSexException implements Exception {
  const SameSexException(this.human1, this.human2);

  final Human human1;
  final Human human2;

  @override
  String toString() =>
      '${human1.name} и ${human2.name} не могут состоять в отношениях, они одного пола!';
}

final class StopRelationship implements Exception {
  const StopRelationship(this.human1, this.human2);

  final Human human1;
  final Human human2;

  @override
  String toString() => ('${human1.name} и ${human2.name} расстались!');
}

final class NotInRelationshipException implements Exception {
  const NotInRelationshipException(this.human1, this.human2);

  final Human human1;
  final Human human2;

  @override
  String toString() =>
      '${human1.name} и ${human2.name} не могут расстаться, они не состояли в отношениях!';
}

Future<void> task1() async {
  /*
  Скопируй свой код из classes.dart сюда и перепеши, заменив принты на throw, 
  пробрасывая какие-то экспешены и обрабатывая их. Сделай функции startRelationship
  и stopRelationship фьючерами и добавь делэй для того, чтобы они успели познакомиться
  друг с другом) Попробуй вызывать эти функции обоими способами (.then и await),
  и также используй соответсвующие обработчики ошибок для них.
  */
  //На данном этапе это все как смог разобраться пока в future, пока что не
  //нашел где искать инфу про ".then"
  final kate = Female(name: 'Катя', age: 23);
  final igor = Male(name: 'Игорь', age: 27);

  igor.salutation(kate);
  try {
    await igor
        .startRelationship(kate)
        .then((value) => null)
        .catchError((error) {
      print(error);
    });
    igor.stopRelationship(kate);
  } catch (e) {
    print(e);
  }
  // try {
  //   igor.stopRelationship(kate);
  // } catch (e) {
  //   print(e);
  // }
  try {
    igor.stopRelationship(kate);
  } catch (e) {
    print(e);
  }
  igor.startRelationship(kate).then((value) => null).catchError((error) {
    print(error);
  });
}

abstract base class Human {
  final String name;
  final int age;
  final Sex sex;
  Human? relationshipStatus;

  Human(this.name, this.age, this.sex);

  void salutation(Human another) {
    print('Привет, ${another.name}!');
  }

  Future<void> startRelationship(Human another) async {
    final delay = await Future.delayed(Duration(seconds: 2), (() => null));
    if (another.relationshipStatus == null &&
        relationshipStatus == null &&
        another.sex != sex) {
      relationshipStatus = another;
      another.relationshipStatus = this;
      throw StartRelationshipException(this, another);
    } else if (another.relationshipStatus != null) {
      throw AlreadyStartedRelationshipException(another);
    } else if (relationshipStatus != null) {
      throw AlreadyStartedRelationshipException(this);
    } else if (another.sex == sex) {
      throw SameSexException(this, another);
    }
    return delay;
  }

  Future<void> stopRelationship(Human another) {
    if (relationshipStatus == another) {
      relationshipStatus = null;
      another.relationshipStatus = null;
      throw StopRelationship(this, another);
    } else {
      throw NotInRelationshipException(this, another);
    }
  }

  @override
  String toString() {
    return '$name(Age: $age, Sex: ${sex.name})';
  }
}

final class Male extends Human {
  Male({required String name, required int age}) : super(name, age, Sex.male);
}

final class Female extends Human {
  Female({required String name, required int age})
      : super(name, age, Sex.female);
}

enum Sex { male, female }
