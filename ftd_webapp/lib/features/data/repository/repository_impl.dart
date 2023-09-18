import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/data/data_sources/graphql_service.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';
import 'package:ftd_webapp/features/data/repository/repository_cache.dart';
import 'package:ftd_webapp/features/domain/repository/repository.dart';

class RepositoryImpl extends Repository with RepositoryCache{
    
    final GraphQLService _graphQLService;

    RepositoryImpl(this._graphQLService);

    @override
    Future<DataState<List<Dataset>>> getDatasetsInfo() async {
      try{
        final result = await _graphQLService.getDatasetsInfo();
        return DataSuccess<List<Dataset>>(result);
      } on Exception catch(e){
        return DataFailed<List<Dataset>>(e);
      }
      
    }

    @override
    Future<DataState<List<Street>>> getStreets(String dataset, bool fromCache) async {
      try{
        if(fromCache && cachedStreets.isNotEmpty && cachedStreets.first.dataset == dataset){
          return DataSuccess<List<Street>>(cachedStreets);
        }
        final result = await _graphQLService.getStreets(dataset);
        cachedStreets = result;
        return DataSuccess<List<Street>>(result);
      } on Exception catch(e){
        return DataFailed<List<Street>>(e);
      }
    }

    @override
    Future<DataState<List<StreetTrafficReport>>> getStreetTrafficReports(DateTime start, DateTime end, String dataset, bool fromCache) async {
      try{
        final result = await _graphQLService.getStreetTrafficReports(start, end, dataset);
        return DataSuccess<List<StreetTrafficReport>>(result);
      } on Exception catch(e){
        return DataFailed<List<StreetTrafficReport>>(e);
      }
    }

    @override
    Future<DataState<List<StreetTrafficReport>>> getStreetTrafficReportsByStreet(String segmentUiid, DateTime start, DateTime end, String dataset) async{
      return throw UnimplementedError();
    }

    ///
    /// The [getGlobalStreetTrafficReports] method retrieve the global street traffic reports from the source for a specific dataset.
    ///
    @override
    Future<DataState<List<StreetTrafficReport>>> getGlobalStreetTrafficReports(String dataset, bool fromCache) async {
      try{ 
        if(fromCache && cachedGlobalStreetTrafficReports.isNotEmpty && cachedStreets.first.dataset == dataset){
          return DataSuccess<List<StreetTrafficReport>>(cachedGlobalStreetTrafficReports);
        }
        final result = await _graphQLService.getGlobalStreetTrafficReports(dataset);
        return DataSuccess<List<StreetTrafficReport>>(result);
      } on Exception catch(e){
        return DataFailed<List<StreetTrafficReport>>(e);
      }
    }

    @override
    Future<DataState<List<StreetTrafficReport>>> getGlobalStreetTrafficReportsByStreet(String streetUiid, String dataset) async {
      return throw UnimplementedError();
    }
    
      

}