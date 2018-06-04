import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/book.dart';
import 'reader_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;
  DetailsScreen({this.book});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: new Stack(
          children: <Widget>[
            _getBackground(book),
            _getGradient(),
            _getContent(book, context),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }
}

List<Chip> tagChips(List<Tags> tags) {
  List<Chip> chips = [];
  tags.forEach((tag) {
    Chip chip = Chip(
      label: new Text(tag.name),
    );
    chips.add(chip);
  });
  return chips;
}

Container _getBackground(Book book) {
  return new Container(
    child: new Image.network(
      "$tUrl/galleries/${book.mediaId}/thumb.${book.images.cover.t}",
      fit: BoxFit.cover,
      height: 300.0,
    ),
    constraints: new BoxConstraints.expand(height: 300.0),
  );
}

Container _getContent(Book book, BuildContext context) {
  return new Container(
    child: new ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 260.0, 0.0, 52.0),
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                book.title.pretty,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new RaisedButton(
                  color: Colors.blue[300],
                  child: new Text("READ"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ReaderScreen(
                          book: book,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _getGradient() {
  return new Container(
    margin: new EdgeInsets.only(top: 190.0),
    height: 110.0,
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
        colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
        stops: [0.0, 0.9],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 1.0),
      ),
    ),
  );
}

Container _getToolbar(BuildContext context) {
  return new Container(
    margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: new BackButton(color: Colors.white),
  );
}
