package fta.data;

public record StreetTrafficReportData(
    Street street,
    int sumTraffic,
    int maxTraffic,
    int minTraffic,
    double avgTraffic,
    double avgVelocity,
    double maxVelocity
) {}
