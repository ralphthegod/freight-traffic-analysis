package fta.repository;

import fta.entity.StreetTrafficReport;
import fta.entity.StreetTrafficReportsEntity;
import fta.mapper.StreetMapper;
import io.quarkus.logging.Log;
import io.quarkus.mongodb.panache.PanacheMongoRepository;
import io.quarkus.mongodb.reactive.ReactiveMongoClient;
import io.quarkus.mongodb.reactive.ReactiveMongoCollection;
import io.quarkus.mongodb.reactive.ReactiveMongoDatabase;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.neo4j.driver.Driver;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import static fta.repository.MongoConstants.FTD_DATABASE_NAME;

@ApplicationScoped
public class StreetTrafficReportsRepository implements PanacheMongoRepository<StreetTrafficReportsEntity> {
    @Inject ReactiveMongoClient reactiveMongoClient;
    @Inject
    Driver neo4jDriver;
    @Inject StreetMapper streetMapper;

    public Uni<List<StreetTrafficReport>> findOrComputeStreetTrafficReports(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return findByDatasetBetween(dataset, first, offset, start, end)
            .flatMap(optionalStreetTrafficReports -> optionalStreetTrafficReports.isPresent()
                ? Uni.createFrom().item(optionalStreetTrafficReports.get().getStreetTrafficReports())
                : buildStreetTrafficReports(dataset, first, offset, start, end)
                    .collect()
                    .asList()
                    .onItem()
                    .invoke(trafficReports -> persistTrafficReports(trafficReports, start, end, dataset)));
    }

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

    public void persistTrafficReports(
        final List<StreetTrafficReport> streetTrafficReports,
        final ZonedDateTime start,
        final ZonedDateTime end,
        final String dataset
    ) {
        persistTrafficReports(streetTrafficReports, start.toInstant(), end.toInstant(), dataset);
    }

    public void persistTrafficReports(
        final List<StreetTrafficReport> streetTrafficReports,
        final Instant start,
        final Instant end,
        final String dataset
    ) {
        Log.infof("Persist traffic reports. Start: %s, End: %s.", start, end);
        final StreetTrafficReportsEntity streetTrafficReportsEntity = new StreetTrafficReportsEntity();
        streetTrafficReportsEntity.setStreetTrafficReports(streetTrafficReports);
        streetTrafficReportsEntity.setStart(start);
        streetTrafficReportsEntity.setEnd(end);
        streetTrafficReportsEntity.setDataset(dataset);
        StreetTrafficReportsEntity.persist(streetTrafficReportsEntity);
    }

    public Multi<StreetTrafficReport> buildStreetTrafficReports(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return Neo4jReactiveSessions.executeRead(neo4jDriver, buildTrafficReportsBetweenQuery(dataset, first, offset, start, end))
            .onItem()
            .transform(streetMapper::toStreetTrafficReport);
    }

    private static String buildTrafficReportsBetweenQuery(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return String.format("""
            MATCH p=(street:Street)-[event:HAS_EVENT]->(timestamp:Timestamp)
            WHERE timestamp.datetime >= datetime("%s") AND timestamp.datetime <= datetime("%s") AND street.dataset = '%s'
            RETURN street,
                SUM(toInteger(event.traffic)) AS sumTraffic,
                MAX(toInteger(event.traffic)) AS maxTraffic,
                MIN(toInteger(event.traffic)) AS minTraffic,
                AVG(toInteger(event.traffic)) AS avgTraffic,
                AVG(toInteger(event.velocity)) AS avgVelocity,
                MAX(toInteger(event.velocity)) AS maxVelocity
            SKIP %s
            LIMIT %s
        """, start, end, dataset, offset, first);
    }
}
