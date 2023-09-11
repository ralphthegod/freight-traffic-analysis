package fta.data;

import java.time.ZonedDateTime;
import java.util.List;

public record StreetTrafficReportsPage(
    ZonedDateTime start,
    ZonedDateTime end,
    int totalCount,
    List<StreetTrafficReportData> streetTrafficReports,
    PageInfo pageInfo
) {}
