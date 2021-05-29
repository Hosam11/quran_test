class QuranMetaModel {
  int? code;
  String? status;
  Data? data;

  QuranMetaModel({this.code, this.status, this.data});

  QuranMetaModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Ayahs? ayahs;
  Sajdas? sajdas;
  Rukus? rukus;
  Pages? pages;
  Manzils? manzils;
  Juzs? juzs;
  HizbQuarters? hizbQuarters;

  Data({
    this.ayahs,
    this.sajdas,
    this.rukus,
    this.pages,
    this.manzils,
    this.juzs,
  });

  Data.fromJson(dynamic json) {
    ayahs = json['ayahs'] != null ? Ayahs.fromJson(json['ayahs']) : null;
    sajdas = json['sajdas'] != null ? Sajdas.fromJson(json['sajdas']) : null;
    rukus = json['rukus'] != null ? Rukus.fromJson(json['rukus']) : null;
    pages = json['pages'] != null ? Pages.fromJson(json['pages']) : null;
    manzils =
        json['manzils'] != null ? Manzils.fromJson(json['manzils']) : null;
    juzs = json['juzs'] != null ? Juzs.fromJson(json['juzs']) : null;
    hizbQuarters = json['hizbQuarters'] != null
        ? HizbQuarters.fromJson(json['hizbQuarters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (ayahs != null) {
      map['ayahs'] = ayahs?.toJson();
    }
    if (sajdas != null) {
      map['sajdas'] = sajdas?.toJson();
    }
    if (rukus != null) {
      map['rukus'] = rukus?.toJson();
    }
    if (pages != null) {
      map['pages'] = pages?.toJson();
    }
    if (manzils != null) {
      map['manzils'] = manzils?.toJson();
    }
    if (juzs != null) {
      map['juzs'] = juzs?.toJson();
    }
    if (hizbQuarters != null) {
      map['hizbQuarters'] = hizbQuarters?.toJson();
    }
    return map;
  }
}

class Juzs {
  int? count;
  List<References>? references;

  Juzs({this.count, this.references});

  Juzs.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class References {
  int? surah;
  int? ayah;

  References({this.surah, this.ayah});

  References.fromJson(dynamic json) {
    surah = json['surah'];
    ayah = json['ayah'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['surah'] = surah;
    map['ayah'] = ayah;
    return map;
  }
}

class Manzils {
  int? count;
  List<References>? references;

  Manzils({this.count, this.references});

  Manzils.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Pages {
  int? count;
  List<References>? references;

  Pages({this.count, this.references});

  Pages.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Rukus {
  int? count;
  List<References>? references;

  Rukus({this.count, this.references});

  Rukus.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Sajdas {
  int? count;
  List<References>? references;

  Sajdas({this.count, this.references});

  Sajdas.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class HizbQuarters {
  int? count;
  List<References>? references;

  HizbQuarters({this.count, this.references});

  HizbQuarters.fromJson(dynamic json) {
    count = json['count'];
    if (json['references'] != null) {
      references = [];
      json['references'].forEach((v) {
        references?.add(References.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    if (references != null) {
      map['references'] = references?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ayahs {
  int? count;

  Ayahs({this.count});

  Ayahs.fromJson(dynamic json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    return map;
  }
}
