import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/core/resources/usecase.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/domain/repository/repository.dart';

class GetStreetDataUseCase extends UseCase<DataState<List<StreetData>>, Map<String,String>>{

  final Repository _repo;

  GetStreetDataUseCase(this._repo);

  @override
  Future<DataState<List<StreetData>>> call({required Map<String, String> params}) async{
    final streetsResult = await _repo.getStreets(params["dataset"]!, true);
    if(streetsResult is DataFailed){
      return DataFailed<List<StreetData>>(streetsResult.error!);
    }
    final streetGlobalTrafficReportsResult = await _repo.getGlobalStreetTrafficReports(params["dataset"]!, true);
    if(streetGlobalTrafficReportsResult is DataFailed){
      return DataFailed<List<StreetData>>(streetGlobalTrafficReportsResult.error!);
    }
    final streetTrafficReportsResult = await _repo.getStreetTrafficReports(DateTime.parse(params["start"]!), DateTime.parse(params["end"]!), params["dataset"]!, true);
    if(streetTrafficReportsResult is DataFailed){
      return DataFailed<List<StreetData>>(streetTrafficReportsResult.error!);
    }

    var builtData = <StreetData>[];

    try{
      builtData = _buildStreetData(streetsResult.data!, streetTrafficReportsResult.data!, streetGlobalTrafficReportsResult.data!);
    } on Exception catch(e){
      return DataFailed<List<StreetData>>(Exception("No data available for the selected period."));
    }

    return DataSuccess<List<StreetData>>(builtData);

  }

  List<StreetData> _buildStreetData(List<Street> streets, List<StreetTrafficReport> streetTrafficReports, List<StreetTrafficReport> streetGlobalTrafficReports){
    final streetData = <StreetData>[];
    logger.f("Streets: ${streets.length}, StreetTrafficReports: ${streetTrafficReports.length}, StreetGlobalTrafficReports: ${streetGlobalTrafficReports.length}");
    try{
      for(final street in streets){
        StreetTrafficReport? streetTrafficReportByStreet;
        StreetTrafficReport? streetGlobalTrafficReportByStreet;

        for(StreetTrafficReport report in streetTrafficReports){
          if(report.streetUUID == street.uuid){
            streetTrafficReportByStreet = report;
            break;
          }
        }
        for(StreetTrafficReport report in streetGlobalTrafficReports){
          if(report.streetUUID == street.uuid){
            streetGlobalTrafficReportByStreet = report;
            break;
          }
        }

        bool hasData = true;

        // ignore: prefer_conditional_assignment
        if(streetTrafficReportByStreet == null){
          streetTrafficReportByStreet = StreetTrafficReport.empty(street.uuid);
        }
        // ignore: prefer_conditional_assignment
        if(streetGlobalTrafficReportByStreet == null){
          streetGlobalTrafficReportByStreet = StreetTrafficReport.empty(street.uuid);
          hasData = false;
        }

        streetData.add(StreetData(street, streetTrafficReportByStreet, streetGlobalTrafficReportByStreet, hasData));
      }
    } on Exception catch(e){
      throw Exception("Bad element.");
    }
    return streetData;
  }

}