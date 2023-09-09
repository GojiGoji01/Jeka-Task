import 'dart:developer';

import 'network/weather_api_service.dart';

Future<void> main() async {
  /* Напиши прогу которая взаимодействует с юзером посредством ВВОДА и ВЫВОДА
  в консоль. Реализуй все, что только можно из апи погоды. Первую строчку я 
  напишу за тебя. Помни, что юзер может вводить что-то что ты не ожидаешь. 
  Апишка грамотно реагирует на неправильные запросы, будет ли твоя прога 
  также отзывычива?? А??

  Первую строчку я по-братски пишу за тебя, она идеальна и неприкосновенна.

  P.S.: Конечно же ничего дописывать в другие файлы, которая уже написаны нельзя.
  Но если нужно ты можешь добавить свои, но не в папку network!
  */

  final myMap = {
    1: 'age',
    200: 'count',
  };
  final age = myMap['asdf'];
  final api = WeatherApiService();
  api.request(Request('Tver', HttpMethod.patch, {})).then((value) {});
  // print(invalidRequest.body['message']);

  final tverHumidityResponse =
      await api.request(Request('/humidity', HttpMethod.get, {
    'measure': 'celsius',
    'city': 'Tver',
  }));
  print(tverHumidityResponse.body);

  final tverWindSpeedResponse = await api
      .request(Request('/windSpeed', HttpMethod.get, {'city': 'Tver'}));
  print(tverWindSpeedResponse.body);
}
