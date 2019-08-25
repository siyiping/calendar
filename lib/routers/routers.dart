import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routers {

  static String page = '/home';

  static void configRouters(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){});
    router.define(page, handler: new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return new
    }));
  }

}