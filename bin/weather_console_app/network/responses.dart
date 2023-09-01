part of 'weather_api_service.dart';

class _NotFoundResponse extends Response {
  _NotFoundResponse() : super(404, {'message': 'Path not found'});
}

class _MethodNotAllowedResponse extends Response {
  _MethodNotAllowedResponse(HttpMethod method)
      : super(405, {'message': '$method method not allowed'});
}

class _BadRequestResponse extends Response {
  _BadRequestResponse([String? message])
      : super(400, {'message': message ?? 'Invalid request params'});
}
