import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/core/resources/usecase.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/providers/data_provider.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/domain/providers/street_provider.dart';

class DashboardStateNotifier extends StateNotifier<DataState<List<StreetData>>> {
  DashboardStateNotifier(this.usecase) : super(const DataEmpty<List<StreetData>>());
  
  final UseCase usecase;

  @override
  set state(DataState<List<StreetData>> value) {
    super.state = value;
  }

  void fetch(Map<String,String> params) async {
    state = const DataLoading<List<StreetData>>("Fetching streets...");
    state = await usecase.call(params: {
      "dataset": params["dataset"]!,
      "start": params["start"]!,
      "end": params["end"]!
    });

    if(state is DataSuccess<List<Street>>){
      logger.d("Street data fetched.");
    }
    else if (state is DataFailed<List<Street>>){
      logger.e("Street data fetch error. ${state.error}");
    }
  }
}

final dashboardStateProvider = StateNotifierProvider.autoDispose<DashboardStateNotifier, DataState<List<StreetData>>>((ref) {
  return DashboardStateNotifier(ref.watch(getStreetsDataProvider));
});