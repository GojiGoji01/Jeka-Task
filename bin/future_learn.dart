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

sealed class AccountFailure implements Exception {}

final class UnknownFailure extends AccountFailure {}

final class NotFoundFailure extends AccountFailure {}

final class ForbiddenFailure extends AccountFailure {}

void a() {
  final AccountFailure failure = NotFoundFailure();

  switch (failure) {
    case UnknownFailure():
      print('');
    case NotFoundFailure():
      print('');
    case ForbiddenFailure():
      print('');
  }
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
    /*
    await не используем вместе с .then, .catchError
    Внизу пример двух корректный, но разный реализаций с объяснением
    */
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
  try {
    // так как мы используем await для выполнения Future, значит, что мы
    // требуем Future выполниться синхронно и будем ожидать его выполнения и
    // возврата значения (или выброса ошибки). В таком случае, чтобы отловить
    // возможные ошибки мы оборачиваем вызов в блок try-catch, где в catch'е
    // мы и ловим эксепшены

    // Вызов
    await igor.startRelationship(kate);

    // В случае если await выполнится успешно, то выполнится эта строчка
    print('success');
  } catch (e) {
    // В противном случае мы проваливаемся в блок catch где у нас есть доступ
    // к выброшенному эксепшену
    print(e);
  }

  // 2 вариант без использования await

  // Во-первых, никакого await, а значит, что функцию начинаем свое выполнение
  // параллельно с остальными командами в вызывающей функции
  igor
      .startRelationship(kate)
      // задаем блок then, который выполнится после успешного выполнения Future
      .then(
    (_) {
      // название параметра прочерк, так как Future возвращает void.
      print('success');
    },
    // определяем блок ошибки, который будет вызван в случае, если Future
    // выбросил эксепшн
  ).catchError((e) {
    print('Не удалость начать отношения между ${igor.name} и ${kate.name}');
    print(e);
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
    /*
    для делэя достаточно просто вызвать синхронно через await Future.delayed()
    и все, прога зависнет на время длительности. Фактически, это Future в котором
    функция с таймером на время, когда время закончится Future уведомляет вызывающую
    функцию о своем успешном выполнении
     */
    await Future.delayed(const Duration(seconds: 2));
    // final delay = await Future.delayed(Duration(seconds: 2), (() => null));
    if (another.relationshipStatus == null &&
        relationshipStatus == null &&
        another.sex != sex) {
      relationshipStatus = another;
      another.relationshipStatus = this;
      // Здесь можно не выбрасывать такой эксепшн, так как вызвав данную
      // Future функцию (startRelationship), мы будем знать, что она удачно
      // выполнилась когда не вылетел ни один эксепшн
      print('$name и ${another.name} начали встречаться!');
    } else if (another.relationshipStatus != null) {
      throw AlreadyStartedRelationshipException(another);
    } else if (relationshipStatus != null) {
      throw AlreadyStartedRelationshipException(this);
    } else if (another.sex == sex) {
      throw SameSexException(this, another);
    }
    // у тебя функция void соответственно необязательно что-то возвращать,
    // тем более этот delay.
    // return delay;
  }

  Future<void> stopRelationship(Human another) async {
    if (relationshipStatus == another) {
      relationshipStatus = null;
      another.relationshipStatus = null;
      print('$name и ${another.name} расстались!');
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
