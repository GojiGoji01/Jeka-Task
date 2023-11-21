import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> main() async {
  /*
  Это второе задание, где мы поработаем с Future.
   
  Я подтянул базовую библиотеку для работы с http-запросами и написал сервис,
  правда успел только написать реализацию только одной функции((( Твоя задача
  дописать вторую функцию, которая дает возможность получить сразу несколько
  имен. Проработай также обработчик ошибок, чтобы пробрасывались ошибки не только
  когда запрос не 200(этот статус означает успешное выполнение), а также другие
  популярные (400 – ошибка запроса, 403 – доступ запрещен, 404 – не найдено).
  Под каждую ошибку можно создать свой эксепшн, я немного помог тебе в этом
  и уже создал базовый класс для этих исключений.

  Также причеши код так, чтобы код не  дублировался, вынеси ключ к апишке в 
  отдельную константу и тд, нужно будет подумать, главное не переборщить))
   */

  final service = RandomNameService();
  try {
    final names = await service.loadNames(amount: -1);
    print(names);
  } on HttpException catch (e) {
    print(e.toString());
  }
}

sealed class HttpException implements Exception {
  @override
  String toString() => switch (this) {
        // норм
        RequestFailed() => 'Ошибка запроса. Проверьте параметры запроса!!',
        Forbidden() =>
          // Нет доступа
          'Пользователь ограничен в доступе к указанному ресурсу!!',
        // Не найдено
        NotFound() => 'Ошибка в написании адреса Web-страницы!!',
      };
}

final class RequestFailed implements HttpException {} // 400 - ошибка запроса

final class Forbidden implements HttpException {} // 403 – доступ запрещен

final class NotFound implements HttpException {} //404 – не найдено

abstract interface class IRandomNameService {
  Future<String> loadName();
  Future<List<String>> loadNames({required int amount});
}

final class RandomNameService implements IRandomNameService {
  @override
  Future<String> loadName() async {
    final response = await http.get(
        Uri.https('randommer.io', '/api/Name', {
          'nameType': 'firstname',
          'quantity': '1',
        }),
        headers: {
          'x-api-key': 'f8f010f6e888495dbce7cc9c02c6cd65',
        });
    _handleError(response.statusCode);

    final list = jsonDecode(response.body) as List;
    return list[0];
  }

  @override
  Future<List<String>> loadNames({required int amount}) async {
    final response = await http.get(
        Uri.https('randommer.io', '/api/Name', {
          'nameType': 'firstname',
          'quantity': amount.toString(),
        }),
        headers: {
          'x-api-key': 'f8f010f6e888495dbce7cc9c02c6cd65',
        });
    _handleError(response.statusCode);
    final listJson = jsonDecode(response.body) as List;
    return listJson.map((e) => e.toString()).toList();
  }
}

void _handleError(int statusCode) {
  if (statusCode == 400) {
    throw RequestFailed();
  } else if (statusCode == 403) {
    throw Forbidden();
  } else if (statusCode == 404) {
    throw NotFound();
  }
  if (statusCode != 200) {
    // создать еще одни силд класс Unknown
    throw Exception('Something goes wrong..');
  }
}
