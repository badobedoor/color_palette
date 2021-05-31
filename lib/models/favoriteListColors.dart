class FavoriteListColors {
  int _id = 0;
  String _title = '';
  int _colorPaletCount = 0;

  FavoriteListColors(
    this._title,
    this._colorPaletCount,
  );
  FavoriteListColors.withId(
    this._id,
    this._title,
    this._colorPaletCount,
  );

  int get id => _id;

  String get title => _title;

  set title(String newtitle) {
    this._title = newtitle;
  }

  int get colorPaletCount => _colorPaletCount;

  set colorPaletCount(int newcolorPaletCount) {
    this._colorPaletCount = newcolorPaletCount;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null && id != 0) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['colorPaletCount'] = _colorPaletCount;

    return map;
  }

  // Extract a Note object from a Map object

  FavoriteListColors.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._colorPaletCount = map['colorPaletCount'];
  }
  //زودت حاجة عشان الدالة دى تشتغل
}
