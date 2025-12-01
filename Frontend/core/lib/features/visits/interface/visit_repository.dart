
import 'package:core/features/visits/data/models/visits.dart';

abstract interface class VisitRepository {
  Future<List<Visit>> fetchVisits(String token);
  Future<bool> createVisit(Visit visit, int family_id, String token);
  Future<bool> createResponseVisit(Response response, int family_id, String token);
}