import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';

abstract class Repository{

  Future<DataState<List<Street>>> getStreets(String dataset, bool fromCache);
  Future<DataState<List<Dataset>>> getDatasetsInfo();

  Future<DataState<List<StreetTrafficReport>>> getStreetTrafficReports(DateTime start, DateTime end, String dataset, bool fromCache);
  Future<DataState<List<StreetTrafficReport>>> getStreetTrafficReportsByStreet(String segmentUiid, DateTime start, DateTime end, String dataset);

  Future<DataState<List<StreetTrafficReport>>> getGlobalStreetTrafficReports(String dataset, bool fromCache);
  Future<DataState<List<StreetTrafficReport>>> getGlobalStreetTrafficReportsByStreet(String streetUiid, String dataset);
  
}