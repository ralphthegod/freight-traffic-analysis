import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/domain/models/street_data.dart';
import 'package:ftd_webapp/features/presentation/states/dashboard_state.dart';
import 'package:ftd_webapp/features/presentation/states/street_analytics_state.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapViewer extends ConsumerWidget with OSMMixinObserver{

  late final MapController _mapController = MapController(
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    );
  bool isAlreadyLoading = false;
  late List<StreetData> data;
  late WidgetRef widgetRef;

  @override
  Widget build(BuildContext context, WidgetRef ref)  {
    double width = MediaQuery.of(context).size.width;
    widgetRef = ref;
    logger.f("MapViewer build");
    _mapController.addObserver(this);
    final state = ref.watch(dashboardStateProvider);
    return 
        SizedBox(
          height: 650,
          width: width,
          child: Stack(children: [
            Consumer(builder:(context, ref, child) 
              {
                if(state is DataSuccess){
                  return OSMFlutter( 
                    controller: _mapController,
                    onMapIsReady: (p0) {
                      data = state.data!;
                      if(!isAlreadyLoading) _addRoads(state.data!);
                    },
                    osmOption: const OSMOption(
                      zoomOption: ZoomOption(
                        initZoom: 8,
                        minZoomLevel: 3,
                        maxZoomLevel: 19,
                        stepZoom: 1.0,
                      ),
                    ),
                  );
                }
                else if(state is DataLoading){
                  return const Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:   CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Loading data...")
                    ],)
                  );
                }
                else if(state is DataFailed){
                  return const Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:   CrossAxisAlignment.center,
                      children: [
                      Icon(Icons.error),
                      SizedBox(height: 20),
                      Text("Error loading data.")
                    ],)
                  );
                }
                return const Align(
                  alignment: Alignment.center,
                  child: Text("Use the control panel to generate data."),
                );
              },
            ),         

          ],)
        );
  }

  @override
  void onRoadTap(RoadInfo road) {
    super.onRoadTap(road);
    final streetData = data.firstWhere((element) => element.roadInfo!.key == road.key);
    widgetRef.read(streetAnalyticsStateProvider.notifier).selectStreet(streetData);
  }

  void _addRoads(List<StreetData> streetData) async{
    _mapController.goToLocation(
      GeoPoint(latitude: streetData[0].street.segments[0].startCoordinates.longitude, longitude: streetData[0].street.segments[0].startCoordinates.latitude)
    );
    for(StreetData sd in streetData){
      StreetPolygon streetPolygon = sd.streetPolygon;
      RoadInfo roadInfo = await _mapController.drawRoad( 
        GeoPoint(latitude: streetPolygon.startCoordinates.longitude, longitude: streetPolygon.startCoordinates.latitude),
        GeoPoint(latitude: streetPolygon.endCoordinates.longitude, longitude: streetPolygon.endCoordinates.latitude),
        roadType: RoadType.car,
        intersectPoint : streetPolygon.middlePoints.map((e) => GeoPoint(latitude: e.longitude, longitude: e.latitude)).toList(),
        roadOption: RoadOption(
            roadWidth: 5,
            roadColor: streetPolygon.color,
            zoomInto: false,
        ),
      );
      sd.roadInfo = roadInfo;
    }
    
  }
  
  @override
  Future<void> mapIsReady(bool isReady) {
    // TODO: implement mapIsReady
    throw UnimplementedError();
  }



}
