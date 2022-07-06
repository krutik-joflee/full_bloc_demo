// ignore_for_file: non_constant_identifier_names, unused_catch_clause
import 'dart:convert';
import 'package:dio/dio.dart';
import '../module/home/model/user_model.dart';

abstract class ApiServices {
  // GET USER DATA FROM API
  static Future<List<User>> getUserDataFromApi(int Listlength) async {
    try {
      var response = await Dio().get(
          "https://verified-mammal-79.hasura.app/api/rest/users",
          queryParameters: {"since": Listlength});

      Welcome listOfUser = welcomeFromJson(jsonEncode(response.data));
      List<User> userlist = listOfUser.users ?? [];
      return userlist;
    } on Exception catch (e) {
      return [];
    }
  }
}
