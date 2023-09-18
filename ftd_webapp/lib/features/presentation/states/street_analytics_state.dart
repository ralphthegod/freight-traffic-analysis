import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/core/resources/usecase.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/providers/data_provider.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/domain/providers/street_provider.dart';

class StreetAnalyticsStateNotifier extends StateNotifier<DataState<StreetData>> {
  StreetAnalyticsStateNotifier() : super(const DataEmpty<StreetData>());

  @override
  set state(DataState<StreetData> value) {
    super.state = value;
  }

  void selectStreet(StreetData street) async {
    state = DataSuccess<StreetData>(street);

    if(state is DataSuccess<Street>){
      logger.d("Street selected.");
    }

    else if (state is DataFailed<Street>){
      logger.e("Street data fetch error. ${state.error}");
    }
  }
}

final streetAnalyticsStateProvider = StateNotifierProvider.autoDispose<StreetAnalyticsStateNotifier, DataState<StreetData>>((ref) {
  return StreetAnalyticsStateNotifier();
});