import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';
import 'package:ftd_webapp/features/data/resources/graphql_query.dart';
import 'package:graphql/client.dart';

class GraphQLService {

  final GraphQLClient _client = GraphQLClient(
    link: HttpLink(GQLApiBaseUrl),
    cache: GraphQLCache(),
  );

  Future<List<Street>> getStreets(String dataset) async{
    int first = 100;
    int offset = 0;
    bool hasNextPage = true;
    final List<Street> streets = [];
    do{
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.getStreetsQuery),
        variables: {
          "first": first,
          "offset": offset,
          "dataset": dataset 
        }
      ));
      streets.addAll(result.data?["streetsPage"]["streets"].map<Street>((e) => Street.fromJson(e)).toList());
      hasNextPage = result.data?["streetsPage"]["pageInfo"]["hasNextPage"];
      offset += first;
    }while(hasNextPage);
    return streets;
  }

  Future<List<StreetTrafficReport>> getStreetTrafficReports(DateTime start, DateTime end, String dataset) async{
      bool hasNextPage = true;
      int first = 100;
      int offset = 0;
      final List<StreetTrafficReport> streetTrafficReports = [];
      do{
        final result = await _client.query(QueryOptions(
          document: gql(GqlQuery.getStreetTrafficReportsQuery),
          variables: {
            "first": first,
            "offset": offset,
            //add Z to the end of the string to make it ISO8601 compliant
            "start": "${start.toIso8601String()}Z",
            "end": "${end.toIso8601String()}Z",
            "dataset": dataset
          }
        ));
        streetTrafficReports.addAll(result.data?["streetTrafficReports"]["streetTrafficReports"].map<StreetTrafficReport>((e) => StreetTrafficReport.fromJson(e)).toList());
        hasNextPage = result.data?["streetTrafficReports"]["pageInfo"]["hasNextPage"];
        offset += first;
      }while(hasNextPage);
      return streetTrafficReports;
  }

  Future<List<Dataset>> getDatasetsInfo() async{
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.getDatasetsInfoQuery),
      ));
      return result.data?["infoDatasets"].map<Dataset>((e) => Dataset.fromJson(e)).toList();
  }

  Future<List<StreetTrafficReport>> getGlobalStreetTrafficReports (String dataset) async {
    bool hasNextPage = true;
    int first = 100;
    int offset = 0;
    final List<StreetTrafficReport> streetTrafficReports = [];
    do{
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.getGlobalStreetTrafficReportsQuery),
        variables: {
          "first": first,
          "offset": offset,
          "dataset": dataset
        }
      ));
      streetTrafficReports.addAll(result.data?["streetTrafficGlobalReports"]["streetTrafficReports"].map<StreetTrafficReport>((e) => StreetTrafficReport.fromJson(e)).toList());
      hasNextPage = result.data?["streetTrafficGlobalReports"]["pageInfo"]["hasNextPage"];
      offset += first;
    }while(hasNextPage);
    return streetTrafficReports;
  }

}