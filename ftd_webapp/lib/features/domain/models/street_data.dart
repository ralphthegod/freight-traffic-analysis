import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:ftd_webapp/features/data/models/segment/segment.dart';
import 'package:ftd_webapp/features/data/models/segment_point/segment_point.dart';
import 'package:ftd_webapp/features/data/models/street/street.dart';
import 'package:ftd_webapp/features/data/models/street_traffic_report/street_traffic_report.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

enum TrafficLevel{
  noData,
  lower,
  same,
  higher
}

class StreetPolygon{
  
  final Color color;
  final SegmentPoint startCoordinates;
  final SegmentPoint endCoordinates;
  final List<SegmentPoint> middlePoints;
  final StreetData streetData;

  StreetPolygon(this.color, this.startCoordinates, this.endCoordinates, this.middlePoints, this.streetData);

}

class StreetData{
  final Street street;
  final StreetTrafficReport trafficReport;
  final StreetTrafficReport globalTrafficReport;
  TrafficLevel trafficLevel = TrafficLevel.noData;
  late RoadInfo roadInfo;

  StreetData(this.street, this.trafficReport, this.globalTrafficReport, bool hasData){
    if(hasData) _calculateTrafficLevel();
  }
  
  StreetPolygon get streetPolygon{
    final List<SegmentPoint> middlePoints = [];
    final MaterialColor color;

    switch(trafficLevel){
      case TrafficLevel.lower:
        color = Colors.green;
        break;
      case TrafficLevel.higher:
        color = Colors.red;
        break;
      case TrafficLevel.same:
        color = Colors.yellow;
        break;
      case TrafficLevel.noData:
        color = Colors.grey;
        break;
    }

    for(Segment segment in street.segments.sublist(1, street.segments.length - 1)){
      middlePoints.add(segment.startCoordinates);
      middlePoints.add(segment.endCoordinates);
    }

    return StreetPolygon(color, street.segments[0].startCoordinates, street.segments.last.endCoordinates, middlePoints, this);

  }

  void _calculateTrafficLevel() {
    if(trafficReport.avgTraffic == 0 && trafficReport.maxTraffic == 0 && trafficReport.minTraffic == 0){
      trafficLevel = TrafficLevel.noData;
    }
    else if(trafficReport.avgTraffic < globalTrafficReport.avgTraffic - 0.6){
      trafficLevel = TrafficLevel.lower;
    }
    else if(trafficReport.avgTraffic > globalTrafficReport.avgTraffic){
      trafficLevel = TrafficLevel.higher;
    }
    else{
      trafficLevel = TrafficLevel.same;
    }
  }


  
}