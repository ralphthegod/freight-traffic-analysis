import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/features/data/providers/data_provider.dart';
import 'package:ftd_webapp/features/domain/usecases/get_street_data.dart';


final getStreetsDataProvider = Provider<GetStreetDataUseCase>((ref) => GetStreetDataUseCase(ref.watch(repositoryProvider)));