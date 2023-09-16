package fta.data;

public record StreetTrafficReportData(
    String streetUUID,
    int sumTraffic,
    int maxTraffic,
    int minTraffic,
    double avgTraffic,
    double avgVelocity,
    double maxVelocity
) {}
