package fta.repository;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import fta.entity.DatasetInfoEntity;
import fta.entity.EventEntity;
import io.quarkus.mongodb.panache.PanacheMongoRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.List;

import static fta.repository.MongoConstants.FTD_DATABASE_NAME;

@ApplicationScoped
public class DatasetInfoRepository implements PanacheMongoRepository<DatasetInfoEntity> {
    @Inject MongoClient mongoClient;

    public void refreshDatasetInfoMaterializedView() {
        final MongoDatabase mongoDatabase = mongoClient.getDatabase(FTD_DATABASE_NAME);
        final MongoCollection<Document> trafficEventsCollections = mongoDatabase.getCollection(EventEntity.COLLECTION_NAME);

        final Document group = Document.parse("""
          { $group: { "_id": "$metadata.dataset", totalEvents: { $count: {} } } }
        """);
        final Document lookup = Document.parse("""
          { $lookup: { from: "polygons", localField: "metadata.dataset", foreignField: "dataset", as: "streets" } }
        """);
        final Document unwind = Document.parse("""
          { $unwind: "$streets" }
        """);
        final Document project = Document.parse("""
          { $project: { _id: 0, name: "$_id", totalEvents: 1, totalStreets: { $size: "$streets.streets" } } }
        """);
        final Document merge = Document.parse("""
          { $merge: { into: "datasetinfo", whenMatched: "replace" } }
        """);

        final List<Bson> pipeline = List.of(group, lookup, unwind, project, merge);
        trafficEventsCollections.aggregate(pipeline).toCollection();
    }

    public boolean isEmpty() {
        return DatasetInfoEntity.findAll().count() == 0;
    }

    public List<DatasetInfoEntity> findAllDatasetInfo() {
        return DatasetInfoEntity.findAll().list();
    }
}
