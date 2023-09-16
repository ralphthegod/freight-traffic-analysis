package fta.entity;

import io.quarkus.mongodb.panache.PanacheMongoEntity;
import io.quarkus.mongodb.panache.common.MongoEntity;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.util.List;

import static fta.entity.DatasetInfoEntity.COLLECTION_NAME;

@Getter
@Setter
@MongoEntity(collection = COLLECTION_NAME)
public class StreetTrafficReportsEntity extends PanacheMongoEntity {
    public static final String COLLECTION_NAME = "streetreports";
    private Instant start;
    private Instant end;
    private String dataset;
    private List<StreetTrafficReport> streetTrafficReports;
}
