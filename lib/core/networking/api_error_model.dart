import 'package:flutter/widgets.dart';

class ApiErrorModel {
  final List<String> messages;
  final IconData icon;
  final int statusCode;
  

  ApiErrorModel({required this.messages, required this.icon, required this.statusCode});

}