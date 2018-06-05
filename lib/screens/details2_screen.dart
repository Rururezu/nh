import 'package:flutter/material.dart';

import '../models/book.dart';

class Details2Screen extends StatelessWidget {

  Details2Screen({this.book});

  final Book book;

  _tagChips(List<Tags> tags) {
    return tags.map((tag) {
      return new Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: new Chip(
          label: new Text(tag.name),
          labelStyle: const TextTheme().caption,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;

    var bookInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          book.title.pretty,
          style: textTheme.title,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Container(),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: new Row(
            children: _tagChips(book.tags),
          ),
        ),
      ],
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          child: bookInformation,
        ),
      ),
    );
  }
}