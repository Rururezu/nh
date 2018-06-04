import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/book.dart';
import '../screens/details_screen.dart';

List<Book> books = [];
List<Card> cards = [];

class ResultScreen extends StatefulWidget {

  final String query;
  ResultScreen({this.query});

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Content(query: widget.query),
    );
  }
}

Future<List<Book>> fetchQuery(String query, int page) async {
  http.Response response = await http.get("$baseUrl/api/galleries/search?query=$query&page=$page");
  List decoded = json.decode(response.body)["result"];
  decoded.forEach((book) {
    books.add(new Book.fromJson(book));
  });
  return books;
}

class Content extends StatefulWidget {

  final String query;
  Content({this.query});

  @override
  _ContentState createState() => new _ContentState();
}

class _ContentState extends State<Content> {

  ScrollController scrollController;
  int page = 1;

  @override
  void initState() {
    books.clear();
    String query = widget.query;
    fetchQuery(query, 1).then((books){
      if(mounted) {
        setState(() {
          books = books;          
        });
      }
    });
    scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter == 0.0) {
      setState(() {
        page += 1;
        fetchQuery(widget.query, page);
      });
    }
  }

  List<Widget> _createBookCards(List<Book> books){
    cards = new List();
    books.forEach((Book book){
      Widget card = new Card(
        child: new GridTile(
          footer: new GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              book.title.pretty,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ),
          child: new GestureDetector(
            child: new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: "$tUrl/galleries/${book.mediaId}/thumb.${book.images.thumbnail.t}",
              fit: BoxFit.cover,
            ),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailsScreen(book: book,)));
            },
          ),
        )
      );
      cards.add(card);
    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return books.isEmpty ? 
    Center(child: new CircularProgressIndicator()) 
    : 
    new Container(
      child: new Scrollbar(
        child: CustomScrollView(
          primary: false,
          controller: scrollController,
          slivers: <Widget>[
            new SliverAppBar(
              title: new Text("nHentai App"),
              centerTitle: true,
              floating: true,
              snap: true,
              forceElevated: true,
            ),
            new SliverPadding(
              padding: const EdgeInsets.all(5.0),
              sliver: new SliverStaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                children: _createBookCards(books),
                staggeredTiles: new List.generate(books.length, (i) => new StaggeredTile.count(1, 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
