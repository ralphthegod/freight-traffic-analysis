package fta.entity;

import io.quarkus.mongodb.panache.PanacheMongoEntity;
import io.quarkus.mongodb.panache.common.MongoEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import static fta.entity.DatasetInfoEntity.COLLECTION_NAME;
import static fta.repository.DatasetInfoRepository.FTD_DATABASE_NAME;

@EqualsAndHashCode(callSuper = true)
@Data
@MongoEntity(collection = COLLECTION_NAME, database = FTD_DATABASE_NAME)
public class DatasetInfoEntity extends PanacheMongoEntity {
    public static final String COLLECTION_NAME = "datasetinfo";

    private String name;
    private int totalStreets;
    private int totalEvents;
}
