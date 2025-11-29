
import 'package:core/features/visits/data/models/visits.dart';

abstract interface class VisitRepository {
  Future<List<Visit>> fetchVisits();
  Future<bool> createVisit(Visit visit, int family_id);
  Future<bool> createResponseVisit(Response response);
}