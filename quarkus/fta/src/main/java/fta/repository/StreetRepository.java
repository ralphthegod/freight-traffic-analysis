package fta.repository;

import fta.data.StreetsPageInfo;
import fta.entity.StreetEntity;
import fta.entity.StreetTrafficReport;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;

import java.time.ZonedDateTime;

public interface StreetRepository {
    Multi<StreetEntity> findStreets(String dataset, int first, int offset);
    Multi<StreetTrafficReport> buildStreetTrafficReports(String dataset, int first, int offset, ZonedDateTime start, ZonedDateTime end);
    Uni<StreetsPageInfo> streetsPageInfoFrom(String dataset, int first, int offset);
}
