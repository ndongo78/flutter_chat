import 'package:flutter/material.dart';



void redirect_page(context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page()));
}
