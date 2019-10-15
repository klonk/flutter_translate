class Lang {

  Lang(this.language,this.name);

  String language;

  String name;

  Lang.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    if (json['language'] == null) {
      language = null;
    } else {
      language = json['language'];
    }
    if (json['name'] == null) {
      name = null;
    } else {
      name = json['name'];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (language != null) json['language'] = language;
    if (name != null) json['name'] = name;
    return json;
  }

    static List<Lang> listFromJson(List<dynamic> json) {
    return json == null ? new List<Lang>() : json.map((value) => new Lang.fromJson(value)).toList();
  }

  static Map<String, Lang> mapFromJson(Map<String, dynamic> json) {
    var map = new Map<String, Lang>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = new Lang.fromJson(value));
    }
    return map;
  }
}
