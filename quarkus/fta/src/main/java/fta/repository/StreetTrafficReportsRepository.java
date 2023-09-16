package fta.repository;

import fta.entity.StreetTrafficReportsEntity;
import io.quarkus.mongodb.panache.PanacheMongoRepository;
import io.quarkus.mongodb.reactive.ReactiveMongoClient;
import io.quarkus.mongodb.reactive.ReactiveMongoCollection;
import io.quarkus.mongodb.reactive.ReactiveMongoDatabase;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import static fta.repository.MongoConstants.FTD_DATABASE_NAME;

@ApplicationScoped
public class StreetTrafficReportsRepository implements PanacheMongoRepository<StreetTrafficReportsEntity> {
    @Inject ReactiveMongoClient reactiveMongoClient;

    public Uni<Optional<StreetTrafficReportsEntity>> findByDatasetBetween(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        final ReactiveMongoDatabase mongoDatabase = reactiveMongoClient.getDatabase(FTD_DATABASE_NAME);
        final List<Bson> pipeline = buildFindByDatasetBetweenPipeline(dataset, first, offset, start, end);
        final ReactiveMongoCollection<Document> streetReportsCollection = mongoDatabase.getCollection(StreetTrafficReportsEntity.COLLECTION_NAME);
        return streetReportsCollection
            .aggregate(pipeline, StreetTrafficReportsEntity.class)
            .toUni()
            .map(Optional::ofNullable);
    }

    private static List<Bson> buildFindByDatasetBetweenPipeline(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        final Document match = Document.parse(String.format("""
            { $match: { dataset: "%s", start: new ISODate("%s"), end: new ISODate("%s") } }
        """, dataset, start, end));
        final Document project = Document.parse(String.format("""
            { $project: { dataset: 1, start: 1, end: 1, streetTrafficReports: { $slice: ["$streetTrafficReports", %s, %s] } } }
        """, offset, first));
        return List.of(match, project);
    }
}
