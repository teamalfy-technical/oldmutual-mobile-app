import 'package:dio/dio.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = initWithBaseUrl(baseUrl: Env.baseUrl);
  }

  static Dio initWithBaseUrl({
    required String baseUrl,
    int connectionTimeout = 30,
    int receiveTimeout = 60,
    int sendTimeout = 60,
    ResponseType responseType = ResponseType.json,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: connectionTimeout),
        receiveTimeout: Duration(seconds: receiveTimeout),
        sendTimeout: Duration(seconds: sendTimeout),
        responseType: responseType,
        // headers: {
        //   'Connection': 'keep-alive',
        //   'Accept-Encoding': 'gzip',
        // },
      ),
    );

    // Add Interceptors for Logging & Error Handling
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          pensionAppLogger.i("📤 Request: ${options.method} ${options.uri}");
          pensionAppLogger.i("📝 Headers: ${options.headers}");
          if (options.data is FormData) {
            FormData formData = options.data as FormData;
            for (var field in formData.fields) {
              pensionAppLogger.i("📦 Payload: ${field.key} = ${field.value}");
            }
          } else {
            pensionAppLogger.i(
              "📦 Payload: ${options.data is FormData ? options.data : options.data}",
            );
          }
          pensionAppLogger.i("📦 QueryParams: ${options.queryParameters}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          pensionAppLogger.d(
            "✅ Response: ${response.statusCode} ${response.data}",
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          pensionAppLogger.e("❌ Error: ${e.response?.statusCode} ${e.message}");
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  Dio get getDio => _dio;
}

// class DioClient {
//   static final DioClient _instance = DioClient._internal();
//   late Dio _dio;

//factory DioClient() => _instance;

//   DioClient._internal() {
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: Env.baseUrl, // Replace with your API base URL
//         connectTimeout: const Duration(seconds: 10),
//         receiveTimeout: const Duration(seconds: 10),
//         responseType: ResponseType.json,
//         headers: {
//           'Accept-Encoding': 'gzip', // Enables compression
//           'Connection': 'keep-alive', // Keeps connection alive
//         },
//       ),
//     )..interceptors.addAll([
//         InterceptorsWrapper(
//           onRequest: (RequestOptions options,
//               RequestInterceptorHandler handler) async {
//             return handler.next(options);
//           },
//           onResponse: (Response response, ResponseInterceptorHandler handler) {
//             if (response.data != null) {
//               return handler.next(response);
//             } else {
//               return handler.reject(DioException(
//                   error: "Empty response data",
//                   requestOptions: response.requestOptions));
//             }
//           },
//           onError: (DioException e, ErrorInterceptorHandler handler) {
//             return handler.reject(e);
//           },
//         ),
//       ]);
//   }

//   Dio get getDio => _dio;
// }
