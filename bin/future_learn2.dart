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
  final name = await service.loadName();

  print(name);
}

sealed class HttpException implements Exception {
  @override
  String toString() => switch (this) {
        RequestFailed() => 'Ошибка запроса. Проверьте параметры запроса!!',
        BadRequest() =>
          'Сервер обнаружил в запросе клиента синтаксическую ошибку!!',
        ForbidenRequest() =>
          'Пользователь ограничен в доступе к указанному ресурсу!!',
        NotFound() => 'Ошибка в написании адреса Web-страницы!!',
      };
}

final class RequestFailed implements HttpException {}

final class BadRequest implements HttpException {} //400 – ошибка запроса

final class ForbidenRequest implements HttpException {} // 403 – доступ запрещен

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
    if (response.statusCode == 400) {
      throw BadRequest();
    } else if (response.statusCode == 403) {
      throw ForbidenRequest();
    } else if (response.statusCode == 404) {
      throw NotFound();
    }
    if (response.statusCode != 200) {
      throw Exception('Something goes wrong..');
    }

    final list = jsonDecode(response.body) as List;
    return list[0];
  }

  @override
  Future<List<String>> loadNames({required int amount}) async {
    List<String> list = [];

    for (int i = 0; i < amount; i++) {
      final response = await http.get(
          Uri.https('randommer.io', '/api/Name', {
            'nameType': 'firstname',
            'quantity': '1',
          }),
          headers: {
            'x-api-key': 'f8f010f6e888495dbce7cc9c02c6cd65',
          });
      if (response.statusCode == 400) {
        throw BadRequest();
      } else if (response.statusCode == 403) {
        throw ForbidenRequest();
      } else if (response.statusCode == 404) {
        throw NotFound();
      }
      if (response.statusCode != 200) {
        throw Exception('Something goes wrong..');
      }
      final listJson = jsonDecode(response.body) as List;
      list[i] = listJson[0];
    }
    return list;
  }
}
