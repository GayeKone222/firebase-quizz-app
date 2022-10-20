import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AnswersModel extends Equatable{
  final String identifier;
  final String answer;

 const AnswersModel({required this.identifier, required this.answer});

  AnswersModel.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  AnswersModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
  
  @override
  List<Object?> get props => [identifier, answer];
}
