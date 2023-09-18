import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/presentation/states/dashboard_state.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/analytics_panel.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/control_panel.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/map_view.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/street_analytics_panel.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/tab_bar.dart';
import 'package:ftd_webapp/features/presentation/widgets/shared/app_bar.dart';
import 'package:tabbed_card/tabbed_card.dart';

class DashboardPage extends ConsumerWidget{

  final Dataset dataset;
  DashboardPage(this.dataset, {super.key});

  late var state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    state = ref.watch(dashboardStateProvider);
    return Scaffold(
      appBar: const MainAppBar(automaticallyImplyLeading: true,),
      body:
        SingleChildScrollView(
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Card(
                    child: SizedBox(
                      height: 650,
                      width: 300,
                      child: AnalyticsPanel()
                    ),
                  ),
                  Expanded(child: MapViewer(),),
                  Card(
                    child: SizedBox(
                      width: 300,
                      height: 650,
                      child: StreetAnalyticsPanel()
                    ),
                  )
                  
                ],
              ),
              Card(
                child:
                  Center(
                    child: SizedBox(
                      height: 211,
                      child: ControlPanel(dataset),
                    ),
                  )
              )
            ],
          ),
        )

    );
  }
}