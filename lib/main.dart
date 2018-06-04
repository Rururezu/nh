import 'package:flutter/material.dart';

import 'screens/frontpage_screen.dart';
import 'models/book.dart';

void main() async {
  //List<Book> books = await fetchFrontPage(1);
  runApp(new MaterialApp(
    home: new HomePage(data: books),
  ));
}

