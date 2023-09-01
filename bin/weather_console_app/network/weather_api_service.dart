import 'dart:math';

part 'responses.dart';

interface class WeatherApiService {
  static const _tver = 'Tver';
  static const _sp = 'Saint-Petersburg';
  static const _london = 'London';
  static const _miami = 'Miami';

  final _availableCities = [_tver, _sp, _london, _miami];

  Future<Response> request(Request request) async {
    if (request.method != HttpMethod.get) {
      return _MethodNotAllowedResponse(request.method);
    }
    await Future.delayed(Duration(seconds: 1 + Random().nextInt(3)));
    return switch (request.path) {
      '/temp' => _tempHandler(request),
      '/humidity' => _humidityHandler(request),
      '/windSpeed' => _windSpeedHandler(request),
      '/airPressure' => _airPressureHandler(request),
      _ => Future.value(_NotFoundResponse()),
    };
  }

  Future<Response> _tempHandler(Request request) async {
    final measure = request.body['measure'] as String?;
    final city = request.body['city'] as String?;
    if (measure != 'celsius' || measure != 'fahrenheit') {
      return _BadRequestResponse('Invalid measure field');
    }
    if (!_availableCities.contains(city)) {
      return _BadRequestResponse('Invalid city field');
    }
    return _temp(measure!, city!);
  }

  Future<Response> _humidityHandler(Request request) async {
    final city = request.body['city'] as String?;
    if (!_availableCities.contains(city)) {
      return _BadRequestResponse('Invalid city field');
    }
    return _humidity(city!);
  }

  Future<Response> _windSpeedHandler(Request request) async {
    final city = request.body['city'] as String?;
    if (!_availableCities.contains(city)) {
      return _BadRequestResponse('Invalid city field');
    }
    return _windSpeed(city!);
  }

  Future<Response> _airPressureHandler(Request request) async {
    final city = request.body['city'] as String?;
    if (!_availableCities.contains(city)) {
      return _BadRequestResponse('Invalid city field');
    }
    return _airPressure(city!);
  }

  Response _temp(String measure, String city) {
    double celsius;
    switch (city) {
      case _tver:
        celsius = 24;
      case _sp:
        celsius = 18;
      case _london:
        celsius = 21;
      case _miami:
        celsius = 28;
      default:
        return _BadRequestResponse('Invalid city field');
    }
    if (measure == 'celsius') {
      return Response(
        200,
        {
          'city': city,
          'measure': measure,
          'temperature': celsius,
        },
      );
    } else {
      return Response(200, {
        'city': city,
        'measure': measure,
        'temperature': (celsius * 9 / 5) + 32
      });
    }
  }

  Response _humidity(String city) {
    int humidity;
    switch (city) {
      case _tver:
        humidity = 60;
      case _sp:
        humidity = 75;
      case _london:
        humidity = 91;
      case _miami:
        humidity = 84;
      default:
        return _BadRequestResponse('Invalid city field');
    }
    return Response(200, {
      'city': city,
      'humidity': humidity,
    });
  }

  Response _windSpeed(String city) {
    int windSpeed;
    switch (city) {
      case _tver:
        windSpeed = 4;
      case _sp:
        windSpeed = 4;
      case _london:
        windSpeed = 1;
      case _miami:
        windSpeed = 0;
      default:
        return _BadRequestResponse('Invalid city field');
    }
    return Response(200, {
      'city': city,
      'windSpeed': windSpeed,
    });
  }

  Response _airPressure(String city) {
    int airPressure;
    switch (city) {
      case _tver:
        airPressure = 767;
      case _sp:
        airPressure = 755;
      case _london:
        airPressure = 759;
      case _miami:
        airPressure = 760;
      default:
        return _BadRequestResponse('Invalid city field');
    }
    return Response(200, {
      'city': city,
      'airPressure': airPressure,
    });
  }
}

class Request {
  const Request(this.path, this.method, this.body);

  final String path;
  final HttpMethod method;
  final Map<String, dynamic> body;
}

class Response {
  const Response(this.statusCode, this.body);

  final int statusCode;
  final Map<String, dynamic> body;
}

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}
