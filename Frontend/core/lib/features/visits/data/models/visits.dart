import 'package:core/features/family/data/models/family_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'visits.freezed.dart';
part 'visits.g.dart';

@freezed
abstract class Visit with _$Visit {
  const Visit._();

  const factory Visit({
    int? id,
    bool? active,
    DateTime? created,
    int? institution_id,
    required int account_id,
    int? family_id,
    required String visit_at,
    String? description,
    required String type_of_visit,
    Response? response,
    FamilyModel? family
  }) = _Visits;

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  String get roleTypeVisit {
    switch (type_of_visit){
      case "ADMISSION": return "Admissão";
      case "READMISSION": return "Readmissão";
      case "ROUTINE": return "Rotina";
      default: return "Desconhecido";
    }
  }
}

@freezed
abstract class Response with _$Response {
  const Response._();

  const factory Response({
    int? visitation_id,
    String? description,
    String? status
  }) = _Response;

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  String get roleStatus {
    switch (status) {
      case "ACCEPTED": return "Aprovada";
      case "REJECTED": return "Reprovada";
      case "PENDING": return "Agendada";
      default: return "Desconhecido";
    }
  }
}