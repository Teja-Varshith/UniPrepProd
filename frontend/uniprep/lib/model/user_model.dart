// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String name;
  final bool profileComplete;
  final String? photoUrl;
  final String emailId;
  final String? collegeName;
  final int? year;
  final int? semester;
  final String? about;
  final String? fcmToken;
  final int coins;
  final bool hasAdFreeAccess;
  
  UserModel({
    this.id,
    required this.name,
    required this.profileComplete,
    this.photoUrl,
    required this.emailId,
    this.collegeName,
    this.year,
    this.semester,
    this.about,
    this.fcmToken,
    required this.coins,
    required this.hasAdFreeAccess,
  });

  UserModel copyWith({
    String? id,
    String? name,
    bool? profileComplete,
    String? photoUrl,
    String? emailId,
    String? collegeName,
    int? year,
    int? semester,
    String? about,
    String? fcmToken,
    int? coins,
    bool? hasAdFreeAccess,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profileComplete: profileComplete ?? this.profileComplete,
      photoUrl: photoUrl ?? this.photoUrl,
      emailId: emailId ?? this.emailId,
      collegeName: collegeName ?? this.collegeName,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      about: about ?? this.about,
      fcmToken: fcmToken ?? this.fcmToken,
      coins: coins ?? this.coins,
      hasAdFreeAccess: hasAdFreeAccess ?? this.hasAdFreeAccess,
    );
  }

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profileComplete': profileComplete,
      'photoUrl': photoUrl,
      'emailId': emailId,
      'collegeName': collegeName,
      'year': year,
      'semester': semester,
      'about': about,
      'fcmToken': fcmToken,
      'coins': coins,
      'hasAdFreeAccess': hasAdFreeAccess,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      profileComplete: map['profileComplete'] as bool,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      emailId: map['emailId'] as String,
      collegeName: map['collegeName'] != null ? map['collegeName'] as String : null,
      year: map['year'] != null ? map['year'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      about: map['about'] != null ? map['about'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      coins: map['coins'] as int,
      hasAdFreeAccess: map['hasAdFreeAccess'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, profileComplete: $profileComplete, photoUrl: $photoUrl, emailId: $emailId, collegeName: $collegeName, year: $year, semester: $semester, about: $about, fcmToken: $fcmToken, coins: $coins, hasAdFreeAccess: $hasAdFreeAccess)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.profileComplete == profileComplete &&
      other.photoUrl == photoUrl &&
      other.emailId == emailId &&
      other.collegeName == collegeName &&
      other.year == year &&
      other.semester == semester &&
      other.about == about &&
      other.fcmToken == fcmToken &&
      other.coins == coins &&
      other.hasAdFreeAccess == hasAdFreeAccess;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      profileComplete.hashCode ^
      photoUrl.hashCode ^
      emailId.hashCode ^
      collegeName.hashCode ^
      year.hashCode ^
      semester.hashCode ^
      about.hashCode ^
      fcmToken.hashCode ^
      coins.hashCode ^
      hasAdFreeAccess.hashCode;
  }
}
