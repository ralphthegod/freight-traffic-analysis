import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/data/providers/data_provider.dart';
import 'package:ftd_webapp/features/domain/repository/repository.dart';

class DatasetSelectionStateNotifier extends StateNotifier<DataState<List<Dataset>>> {
  DatasetSelectionStateNotifier(this.repo) : super(const DataEmpty<List<Dataset>>()){
    fetch({});
  }
  final Repository repo;

  void fetch(Map<String,String> params) async {
    state = const DataLoading<List<Dataset>>("Fetching datasets...");
    state = await repo.getDatasetsInfo();
    if(state is DataSuccess<List<Dataset>>){
      logger.d("Dataset fetched.");
    }
    else if (state is DataFailed<List<Dataset>>){
      logger.e("Dataset fetch error.${state.error}");
    }
  }
}

final datasetSelectionStateProvider = StateNotifierProvider.autoDispose<DatasetSelectionStateNotifier, DataState<List<Dataset>>>((ref) {
  return DatasetSelectionStateNotifier(ref.watch(repositoryProvider));
});