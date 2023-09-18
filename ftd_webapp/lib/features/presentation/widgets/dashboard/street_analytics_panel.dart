import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/presentation/states/dashboard_state.dart';
import 'package:ftd_webapp/features/presentation/states/street_analytics_state.dart';
import 'package:ftd_webapp/features/presentation/widgets/shared/analytics/bar_chart.dart';

class StreetAnalyticsPanel extends ConsumerWidget{
  
  StreetAnalyticsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(streetAnalyticsStateProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Street Analytics",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              if(state is DataLoading){
                return const Text("");
              }
              else if(state is DataSuccess){
                StreetData street = state.data!;
                return Align(
                  alignment: Alignment.center,
                  child: Column(children: [
                    Text("Street loaded: ${street.street.dataset}_${street.street.id}"),
                    const SizedBox(height: 10),
                    Text("Length: ${street.roadInfo.distance!.toStringAsFixed(1)} km"),
                  ],)
                );
              }
              else if(state is DataFailed){
                return const Text("No street loaded.");
              }
              else{
                return const Align(
                  alignment: Alignment.center,
                  child: Text("No street loaded")
                );
              }
            },
          ),
          const SizedBox(height: 20),
          const Text("Traffic Comparison",
            style: TextStyle(
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          Consumer(builder: (context, ref, child) {
            if(state is DataSuccess){
              StreetData street = state.data!;
              return _getTrafficData(street);
            }
            return Text("");
          },),

          const SizedBox(height: 10),

          _getLegend(),

          const SizedBox(height: 20),

          Consumer(
            builder: (context, ref, child) {
              if(state is DataLoading){
                return const CircularProgressIndicator();
              }
              else if(state is DataSuccess){
                StreetData street = state.data!;
                return _getChart(
                  [
                    ChartData("Average", street.trafficReport.avgTraffic, street.globalTrafficReport.avgTraffic),
                    ChartData("Max", street.trafficReport.maxTraffic, street.globalTrafficReport.maxTraffic),
                    ChartData("Min", street.trafficReport.minTraffic, street.globalTrafficReport.minTraffic),
                  ]
                );
              }
              else if(state is DataFailed){
                return Text("Error loading data");
              }
              else{
                return Text("");
              }
            },
          ),
          const SizedBox(height: 20),
          const Text("Speed Comparison",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          _getLegend(),
          const SizedBox(height: 20),
          Consumer(
            builder: (context, ref, child) {
              if(state is DataLoading){
                return const CircularProgressIndicator();
              }
              else if(state is DataSuccess){
                StreetData street = state.data!;
                logger.f("Street: ${street.street.uuid}, ${street.trafficReport.avgTraffic}, ${street.globalTrafficReport.avgTraffic}, ${street.trafficReport.avgVelocity}, ${street.globalTrafficReport.avgVelocity}");
                return _getChart(
                  [
                    ChartData("Average", street.trafficReport.avgVelocity, street.globalTrafficReport.avgVelocity),
                    ChartData("Max", street.trafficReport.maxVelocity, street.globalTrafficReport.maxVelocity),
                  ]
                );
              }
              else if(state is DataFailed){
                return Text("Error loading data");
              }
              else{
                return Text("");
              }
            },
          ),

          
        ]
      )  
    );
  }

  Widget _getTrafficData(StreetData data){
    return Column(children: [
      SizedBox(
      child: 
        Text("Total Traffic:  ${data.trafficReport.sumTraffic}")
      ),
      SizedBox(
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Avg. Traffic:  ${data.trafficReport.avgTraffic.toStringAsFixed(2)}"),
            SizedBox(width: 30),
            Text("Global Avg. Traffic:  ${data.globalTrafficReport.avgTraffic.toStringAsFixed(2)}"),
        ],)
      ),
      SizedBox(
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Max. Traffic:  ${data.trafficReport.maxTraffic.toStringAsFixed(2)}"),
            SizedBox(width: 30),
            Text("Global Max. Traffic:  ${data.globalTrafficReport.maxTraffic.toStringAsFixed(2)}"),
        ],)
      ),
      SizedBox(
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Min. Traffic:  ${data.trafficReport.minTraffic.toStringAsFixed(2)}"),
            SizedBox(width: 30),
            Text("Global Min. Traffic:  ${data.globalTrafficReport.minTraffic.toStringAsFixed(2)}"),
        ],)
      )
    ],);
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

  Widget _getChart(List<ChartData> data){
    return SizedBox(
        height: 300,
        child: Expanded(
          child: BarChartSample2(data),
        )
      );
}
}