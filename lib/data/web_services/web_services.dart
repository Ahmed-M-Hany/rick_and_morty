import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/constants/strings.dart';

class WebServices{
  late Dio dio;
  WebServices(){
    BaseOptions options=BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
    );
    dio=Dio(options);
  }
  
  Future getAllCharacters()async{
    try{
      Response response= await dio.get('/character');
      if (kDebugMode) {
        print("mammamiaaaaaaaaaaaaaaaa");
      }
      return response.data;
    }catch(e){
      if (kDebugMode) {
        print("hellooooooooooooooooooo$e");
      }
      return [];
    }

  }
  
}