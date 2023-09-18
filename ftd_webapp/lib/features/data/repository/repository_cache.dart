import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';

mixin RepositoryCache{

  List<Street> cachedStreets = [];
  List<StreetTrafficReport> cachedGlobalStreetTrafficReports = [];

}