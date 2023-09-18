import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/presentation/states/dashboard_state.dart';
import 'package:ftd_webapp/features/presentation/widgets/shared/analytics/bar_chart.dart';
import 'package:ftd_webapp/features/presentation/widgets/shared/analytics/pie_chart.dart';

class AnalyticsPanel extends ConsumerWidget{
  
  AnalyticsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardStateProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Analytics",
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20),

          Consumer(builder:(context, ref, child) {
            if(state is DataSuccess){
              return Text("Streets loaded: ${state.data!.length}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              );
            }
            else if(state is DataLoading){
              return const Text("");
            }
            else if(state is DataFailed){
              return const Text("Streets loaded: 0");
            }
            else{
              return const Text("Streets loaded: 0");
            }
          },),

          const SizedBox(height: 30),


          Consumer(
            builder: (context, ref, child) {
              if(state is DataLoading){
                return const CircularProgressIndicator();
              }
              else if(state is DataSuccess){
                int noDataStreet = state.data!.where((element) => element.trafficLevel == TrafficLevel.noData).length;
                int lowTrafficStreet = state.data!.where((element) => element.trafficLevel == TrafficLevel.lower).length;
                int mediumTrafficStreet = state.data!.where((element) => element.trafficLevel == TrafficLevel.same).length;
                int highTrafficStreet = state.data!.where((element) => element.trafficLevel == TrafficLevel.higher).length;
                return SizedBox(
                  height: 300,
                  child: Expanded(
                    child: _getPieChart(
                      [
                        PieChartData(0, noDataStreet.toDouble(), "No Data", Colors.grey),
                        PieChartData(1, lowTrafficStreet.toDouble(), "Lower", Colors.green),
                        PieChartData(2, mediumTrafficStreet.toDouble(), "Same", Colors.yellow),
                        PieChartData(3, highTrafficStreet.toDouble(), "Higher", Colors.red),
                      ]
                    ),
                  )
                );
              }
              else if(state is DataFailed){
                return Text("Error loading data");
              }
              else{
                return Text("No data loaded.");
              }
            },
          ),

          const SizedBox(height: 30),

          
        ]
      )  
    );
  }

  Widget _getPieChart(List<PieChartData> data){
    return PieChart(data);
  }


  Widget _getLegend(){
    return const SizedBox(
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.circle, color: Colors.green),
          SizedBox(width: 10),
          Text("Selected"),
          SizedBox(width: 30),
          Icon(Icons.circle, color: Colors.red),
          SizedBox(width: 10),
          Text("Global"),
        ],)
      );
  }

}