import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  int? id;
  String? title;
  String? employmentType;
  String? major;
  String? city;
  String? companyName;
  int? experience;
  String? date;
  String? views;
  String? description;
  String? benefits;
  String? requirements;
  int? hasApplied;
  int? hasViewed;
  int? isFavourite;
  int? applicants_count;
  List? majors;
  String? address;
  String? email;
  String? first_name;
  String? last_name;
  String? occupation;
  String? company_description;
  String? avatar_path;

  JobEntity({
    this.id,
    this.title,
    this.employmentType,
    this.major,
    this.city,
    this.companyName,
    this.experience,
    this.date,
    this.views,
    this.description,
    this.benefits,
    this.requirements,
    this.hasApplied,
    this.hasViewed,
    this.isFavourite,
    this.applicants_count,
    this.majors,
    this.address,
    this.email,
    this.first_name,
    this.last_name,
    this.occupation,
    this.company_description,
    this.avatar_path,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        employmentType,
        major,
        city,
        companyName,
        experience,
        date,
        views,
        description,
        benefits,
        requirements,
        hasApplied,
        hasViewed,
        isFavourite,
        applicants_count,
        majors,
        address,
        email,
        first_name,
        last_name,
        occupation,
        company_description,
        avatar_path,
      ];
}
