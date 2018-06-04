import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoomable_image/zoomable_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:async';
import 'dart:io';

import '../constants.dart';
import '../models/book.dart';

class ReaderScreen extends StatefulWidget {

  final Book book;
  ReaderScreen({this.book});

  @override
  ReaderScreenState createState() {
    return new ReaderScreenState();
  }
}

class ReaderScreenState extends State<ReaderScreen> {

  PageController _controller;
  ZoomableImage currPage, nextPage;

  @override
  void initState(){
    _controller = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<CachedNetworkImageProvider>> _loadAllImages(Book book) async {
    List<CachedNetworkImageProvider> cachedImages = [];
    for(int i=0;i<book.numPages;i++) {
      var configuration = createLocalImageConfiguration(context);
      cachedImages.add(
        new CachedNetworkImageProvider(
          "$iUrl/galleries/${widget.book.mediaId}/${i+1}.${widget.book.images.pages[i].t}",
          headers: {HttpHeaders.USER_AGENT: headers},
          )..resolve(configuration),
        );
    }
    return cachedImages;
  }

  FutureBuilder<List<CachedNetworkImageProvider>> _futurePages(Book book) {
    return new FutureBuilder(
      future: _loadAllImages(book),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData) {
          return new Container(
            child: PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ImageProvider image = snapshot.data[index];
                return new ZoomableImage(
                  image, 
                  placeholder: new Center(
                    child: new CupertinoActivityIndicator(),
                  ),
                );
              },
              onPageChanged: (int index) {
              },
            ),
          );
        } else if(!snapshot.hasData) return new Center(child: CupertinoActivityIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _futurePages(widget.book),
    );
  }
}