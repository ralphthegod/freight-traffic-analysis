package fta.repository;

import fta.data.StreetsPageInfo;
import fta.entity.StreetEntity;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;

public interface StreetRepository {
    Multi<StreetEntity> findStreets(String dataset, int first, int offset);
    Uni<StreetsPageInfo> streetsPageInfoFrom(String dataset, int first, int offset);
}
