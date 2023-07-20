// import 'dart:convert';

// class Cast {
//     int id;
//     List<CastElement> cast;
//     List<CastElement> crew;

//     Cast({
//         required this.id,
//         required this.cast,
//         required this.crew,
//     });

//     factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Cast.fromJson(Map<String, dynamic> json) => Cast(
//         id: json["id"],
//         cast: List<CastElement>.from(json["cast"].map((x) => CastElement.fromJson(x))),
//         crew: List<CastElement>.from(json["crew"].map((x) => CastElement.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
//         "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
//     };
// }

// class CastElement {
//     bool adult;
//     int gender;
//     int id;
//     String knownForDepartment;
//     String name;
//     String originalName;
//     double popularity;
//     String? profilePath;
//     int? castId;
//     String? character;
//     String creditId;
//     int? order;
//     String? department;
//     String? job;

//     CastElement({
//         required this.adult,
//         required this.gender,
//         required this.id,
//         required this.knownForDepartment,
//         required this.name,
//         required this.originalName,
//         required this.popularity,
//         this.profilePath,
//         this.castId,
//         this.character,
//         required this.creditId,
//         this.order,
//         this.department,
//         this.job,
//     });

//     factory CastElement.fromRawJson(String str) => CastElement.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory CastElement.fromJson(Map<String, dynamic> json) => CastElement(
//         adult: json["adult"],
//         gender: json["gender"],
//         id: json["id"],
//         knownForDepartment: json["known_for_department"]!,
//         name: json["name"],
//         originalName: json["original_name"],
//         popularity: json["popularity"]?.toDouble(),
//         profilePath: json["profile_path"],
//         castId: json["cast_id"],
//         character: json["character"],
//         creditId: json["credit_id"],
//         order: json["order"],
//         department: json["department"]!,
//         job: json["job"],
//     );

//     Map<String, dynamic> toJson() => {
//         "adult": adult,
//         "gender": gender,
//         "id": id,
//         "known_for_department": departmentValues.reverse[knownForDepartment],
//         "name": name,
//         "original_name": originalName,
//         "popularity": popularity,
//         "profile_path": profilePath,
//         "cast_id": castId,
//         "character": character,
//         "credit_id": creditId,
//         "order": order,
//         "department": departmentValues.reverse[department],
//         "job": job,
//     };
// }

// enum Department { ACTING, WRITING, EDITING, PRODUCTION, DIRECTING, VISUAL_EFFECTS, SOUND, ART, COSTUME_MAKE_UP, CREW, CAMERA, LIGHTING }

// final departmentValues = EnumValues({
//     "Acting": Department.ACTING,
//     "Art": Department.ART,
//     "Camera": Department.CAMERA,
//     "Costume & Make-Up": Department.COSTUME_MAKE_UP,
//     "Crew": Department.CREW,
//     "Directing": Department.DIRECTING,
//     "Editing": Department.EDITING,
//     "Lighting": Department.LIGHTING,
//     "Production": Department.PRODUCTION,
//     "Sound": Department.SOUND,
//     "Visual Effects": Department.VISUAL_EFFECTS,
//     "Writing": Department.WRITING
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }


import 'dart:convert';

Credits creditsFromJson(String str) => Credits.fromJson(json.decode(str));

String creditsToJson(Credits data) => json.encode(data.toJson());

class Credits {
  int id;
  List<Cast> cast;
  List<Cast> crew;

  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };

  static fromRawJson(String body) {}
}

class Cast {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        // knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        // department: departmentValues.map[json["department"]]!,
        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": job,
      };
}

enum Department {
  ACTING,
  VISUAL_EFFECTS,
  CAMERA,
  DIRECTING,
  SOUND,
  WRITING,
  ART,
  PRODUCTION
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Directing": Department.DIRECTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}






