import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/presentation/pages/dashboard.dart';
import 'package:ftd_webapp/features/presentation/states/dataset_selection_state.dart';
import 'package:ftd_webapp/features/presentation/widgets/dataset_selection/dataset_item.dart';
import 'package:ftd_webapp/features/presentation/widgets/shared/app_bar.dart';

class DatasetSelectionPage extends ConsumerWidget{

  late var state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    state = ref.watch(datasetSelectionStateProvider);
    return Scaffold(
      appBar: const MainAppBar(automaticallyImplyLeading: false,),
      body:
        Align(
          alignment: Alignment.topCenter,
          child: 
            Padding(padding: const EdgeInsets.all(150),
            child:
              SingleChildScrollView(
                child:
                  Column(
                    mainAxisSize:MainAxisSize.min,
                    children: [
                      const Text("Welcome to FTA",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 30),

                      const Text(description,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 80),
                      const Text("Available datasets",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),
                      
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                          Consumer(builder: (context, ref, child) {
                            final state = ref.watch(datasetSelectionStateProvider);
                            if(state is DataLoading<List<Dataset>>){
                              return const Center(child: CircularProgressIndicator());
                            }
                            else if(state is DataSuccess<List<Dataset>>){
                              return _getDatasetList(context, ref, state.data!);
                            }
                            else if(state is DataFailed<List<Dataset>>){
                              return Center(child: Text(state.error.toString()));
                            }
                            else{
                              return const Center(child: CircularProgressIndicator());
                            }
                          })
                        ,
                      ),
                      

                    ],
                  ),
              )
            ),
        )
    );
  }

  Widget _getDatasetList(BuildContext context, WidgetRef ref, List<Dataset> datasets){
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: state.data!.length,
        itemBuilder: (context, index) {
          return DatasetListItem(
            dataset: state.data![index],
            loadDatasetCallback: (dataset) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage(dataset)));
            },
          );
        },
      );
  }
}

const String description = "This platform is designed to facilitate data-driven analysis by allowing users to efficiently import datasets from a database. The application specializes in the analysis of traffic data, providing users with a range of analytical capabilities. Whether one is an experienced data analyst or a newcomer to the field, the user-friendly interface enables exploration, visualization, and in-depth analysis of traffic-related datasets.";