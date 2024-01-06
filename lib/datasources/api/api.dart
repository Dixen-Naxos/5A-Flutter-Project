import 'package:dio/dio.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
    ),
  );
  //dio.options.headers["Authorization"] = "token";
}
