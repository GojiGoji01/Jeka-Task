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
    final names = await service.loadNames(amount: 2, nameType: 0);
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
        UnknownException() => 'Неизвестная ошибка!' //неизвестная ошибка
      };
}

final class RequestFailed extends HttpException {} // 400 - ошибка запроса

final class Forbidden extends HttpException {} // 403 – доступ запрещен

final class NotFound extends HttpException {} //404 – не найдено

final class UnknownException extends HttpException {} // != 200

abstract interface class IRandomNameService {
  Future<String> loadName({required int nameType});
  Future<List<String>> loadNames({required int amount, required int nameType});
}

final class RandomNameService implements IRandomNameService {
  @override
  Future<String> loadName({required int nameType}) async {
    String name = getNameType(nameType);
    final response = await http.get(
        Uri.https('randommer.io', '/api/Name', {
          'nameType': name,
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
  Future<List<String>> loadNames(
      {required int amount, required int nameType}) async {
    String name = getNameType(nameType);
    final response = await http.get(
        Uri.https('randommer.io', '/api/Name', {
          'nameType': name,
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

String getNameType(int nameType) {
  if (nameType == 1) {
    return 'fullname';
  } else if (nameType == 2) {
    return 'surname';
  } else {
    return 'firstname';
  }
}

void _handleError(int statusCode) {
  if (statusCode == 400) {
    throw RequestFailed();
  } else if (statusCode == 403) {
    throw Forbidden();
  } else if (statusCode == 404) {
    throw NotFound();
  } else if (statusCode != 200) {
    throw UnknownException();
  }
}
//nametype


