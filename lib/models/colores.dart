class Colores {
  int _id = 0;
  String _title = '';
  int _look = 0;
  int _chose = 0;
  String _rgbColor = '';
  String _hexColor = '';
  int _colorPaletId = 0;

  Colores(
    this._title,
    this._look,
    this._chose,
    this._rgbColor,
    this._hexColor,
    this._colorPaletId,
  );
  Colores.withId(
    this._id,
    this._title,
    this._look,
    this._chose,
    this._rgbColor,
    this._hexColor,
    this._colorPaletId,
  );

  int get id => _id;

  String get title => _title;

  set title(String newtitle) {
    this._title = newtitle;
  }

  int get look => _look;
  set look(int newlook) {
    this._look = newlook;
  }

  int get chose => _chose;
  set chose(int newchose) {
    this._chose = newchose;
  }

  String get rgbColor => _rgbColor;
  set rgbColor(String newrgbColor) {
    this._rgbColor = newrgbColor;
  }

  String get hexColor => _hexColor;

  set hexColor(String newhexColor) {
    this._hexColor = newhexColor;
  }

  int get colorPaletId => _colorPaletId;

  set colorPaletId(int newcolorPaletId) {
    this._colorPaletId = newcolorPaletId;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null && id != 0) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['look'] = _look;
    map['chose'] = _chose;
    map['rgbColor'] = _rgbColor;
    map['hexColor'] = _hexColor;
    map['colorPaletId'] = _colorPaletId;

    return map;
  }

  // Extract a Note object from a Map object

  Colores.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._look = map['look'];
    this._chose = map['chose'];
    this._rgbColor = map['rgbColor'];
    this._hexColor = map['hexColor'];
    this._colorPaletId = map['colorPaletId'];
  }
  //زودت حاجة عشان الدالة دى تشتغل
}
