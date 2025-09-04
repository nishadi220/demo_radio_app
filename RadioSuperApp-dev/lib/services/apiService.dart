import 'package:dio/dio.dart';

import 'dioClient.dart';

class ApiService {

  final DioClient dioClient;

  ApiService({required this.dioClient});

  Future<Response> getData(String endpoint) async {
    try {
      Response response = await dioClient.dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors here
      throw Exception('Failed to get data: ${e.message}');
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dioClient.dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors here
      throw Exception('Failed to post data: ${e.message}');
    }
  }

  Future<Response> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dioClient.dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors here
      throw Exception('Failed to update data: ${e.message}');
    }
  }

  Future<Response> deleteData(String endpoint) async {
    try {
      Response response = await dioClient.dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors here
      throw Exception('Failed to delete data: ${e.message}');
    }
  }
}