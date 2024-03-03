// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  int? id;
  String? role;
  String? username;
  String? first_name;
  String? last_name;
  String? father_name;
  String? mother_name;
  String? avatar_path;
  String? email;
  String? password;
  String? confirm_password;
  Map? complete;

  // USER
  int? university_id;
  int? major_id;
  bool? has_submission;
  String? submission_status;
  String? resume_path;
  int? submission_id;
  int? approved;

  // COMPANY
  String? company;
  String? company_description;
  String? distinctive_title;
  String? occupation;
  String? afm;
  String? doy;
  String? address;
  String? city;
  String? postal_code;

  UserEntity({
    this.id,
    this.role,
    this.username,
    this.first_name,
    this.last_name,
    this.father_name,
    this.mother_name,
    this.avatar_path,
    this.email,
    this.password,
    this.confirm_password,
    this.complete,
    this.university_id,
    this.major_id,
    this.has_submission,
    this.submission_status,
    this.resume_path,
    this.submission_id,
    this.approved,
    this.company,
    this.company_description,
    this.distinctive_title,
    this.occupation,
    this.afm,
    this.doy,
    this.address,
    this.city,
    this.postal_code,
  });

  @override
  List<Object?> get props => [
        id,
        role,
        username,
        first_name,
        last_name,
        father_name,
        mother_name,
        avatar_path,
        email,
        password,
        confirm_password,
        complete,
        university_id,
        major_id,
        has_submission,
        submission_status,
        resume_path,
        submission_id,
        approved,
        company,
        company_description,
        distinctive_title,
        occupation,
        afm,
        doy,
        address,
        city,
        postal_code,
      ];
}
