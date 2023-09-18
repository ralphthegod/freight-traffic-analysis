
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/features/data/data_sources/graphql_service.dart';
import 'package:ftd_webapp/features/data/repository/repository_impl.dart';
import 'package:ftd_webapp/features/domain/repository/repository.dart';

final _ApiServiceProvider = Provider<GraphQLService>((ref) => GraphQLService());

final repositoryProvider = Provider<Repository>(
  (ref) => RepositoryImpl(
    ref.watch(_ApiServiceProvider),
  ),
);