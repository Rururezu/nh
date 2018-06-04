class Book {
  dynamic id;
  String mediaId;
  Title title;
  Images images;
  String scanlator;
  int uploadDate;
  List<Tags> tags;
  int numPages;
  int numFavorites;

  Book(
      {this.id,
        this.mediaId,
        this.title,
        this.images,
        this.scanlator,
        this.uploadDate,
        this.tags,
        this.numPages,
        this.numFavorites});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaId = json['media_id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    scanlator = json['scanlator'];
    uploadDate = json['upload_date'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    numPages = json['num_pages'];
    numFavorites = json['num_favorites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media_id'] = this.mediaId;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['scanlator'] = this.scanlator;
    data['upload_date'] = this.uploadDate;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['num_pages'] = this.numPages;
    data['num_favorites'] = this.numFavorites;
    return data;
  }
}

class Title {
  String english;
  String japanese;
  String pretty;

  Title({this.english, this.japanese, this.pretty});

  Title.fromJson(Map<String, dynamic> json) {
    english = json['english'];
    japanese = json['japanese'] != null ? json['japanese'] : null;
    pretty = json['pretty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english'] = this.english;
    data['japanese'] = this.japanese;
    data['pretty'] = this.pretty;
    return data;
  }
}

class Images {
  List<Pages> pages;
  Cover cover;
  Thumbnail thumbnail;

  Images({this.pages, this.cover, this.thumbnail});

  Images.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = new List<Pages>();
      json['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
    cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages.map((v) => v.toJson()).toList();
    }
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    return data;
  }
}

class Pages {
  String t;
  int w;
  int h;

  Pages({this.t, this.w, this.h});

  Pages.fromJson(Map<String, dynamic> json) {
    t = json['t'] == "p" ? "png" : "jpg";
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['w'] = this.w;
    data['h'] = this.h;
    return data;
  }
}

class Cover {
  String t;
  int w;
  int h;

  Cover({this.t, this.w, this.h});

  Cover.fromJson(Map<String, dynamic> json) {
    t = json['t'] == "p" ? "png" : "jpg";
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['w'] = this.w;
    data['h'] = this.h;
    return data;
  }
}

class Thumbnail {
  String t;
  int w;
  int h;

  Thumbnail({this.t, this.w, this.h});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    t = json['t'] == "p" ? "png" : "jpg";
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['w'] = this.w;
    data['h'] = this.h;
    return data;
  }
}

class Tags {
  int id;
  String type;
  String name;
  String url;
  int count;

  Tags({this.id, this.type, this.name, this.url, this.count});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    data['count'] = this.count;
    return data;
  }
}