import 'package:equatable/equatable.dart';

class AuthenticationDetailModel extends Equatable {
  final bool? isValid;
  final String? uid;
  final String? photoUrl;
  final String? email;
  final String? name;

  const AuthenticationDetailModel({
    required this.isValid,
    this.uid,
    this.photoUrl,
    this.email,
    this.name,
  });

  AuthenticationDetailModel copyWith({
    bool? isValid,
    String? uid,
    String? photoUrl,
    String? email,
    String? name,
  }) {
    return AuthenticationDetailModel(
      isValid: isValid ?? this.isValid,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValid'] = isValid;
    data['uid'] = uid;
    data['photoUrl'] = photoUrl;
    data['email'] = email;
    data['name'] = name;
    return data;
  }

  AuthenticationDetailModel.fromJson(Map<String, dynamic> json)
      : isValid = json['isValid'],
        uid = json['uid'],
        photoUrl = json['photoUrl'],
        email = json['email'],
        name = json['name'];

  @override
  String toString() {
    return 'AuthenticationDetail(isValid: $isValid, uid: $uid, photoUrl: $photoUrl, email: $email, name: $name)';
  }

  @override
  List<Object?> get props => [isValid, uid, photoUrl, email, name];
}
