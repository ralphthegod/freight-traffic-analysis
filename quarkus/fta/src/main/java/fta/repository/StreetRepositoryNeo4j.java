package fta.repository;

import fta.data.StreetsPageInfo;
import fta.entity.StreetEntity;
import fta.entity.StreetTrafficReport;
import fta.mapper.StreetMapper;
import io.quarkus.logging.Log;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Record;
import org.neo4j.driver.Value;
import org.neo4j.driver.types.Node;
import org.neo4j.driver.types.Path;

import java.time.ZonedDateTime;

@ApplicationScoped
public class StreetRepositoryNeo4j implements StreetRepository {
    @Inject Driver driver;
    @Inject StreetMapper streetMapper;

    private static final int STREET_UNIT = 5;
    private static String buildTrafficReportsBetweenQuery(
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return String.format("""
            MATCH p=(street:Street)-[event:HAS_EVENT]->(timestamp:Timestamp)
            WHERE timestamp.datetime >= datetime("%s") AND timestamp.datetime <= datetime("%s")
            RETURN street,
                SUM(toInteger(event.traffic)) AS sumTraffic,
                MAX(toInteger(event.traffic)) AS maxTraffic,
                MIN(toInteger(event.traffic)) AS minTraffic,
                AVG(toInteger(event.traffic)) AS avgTraffic,
                AVG(toInteger(event.velocity)) AS avgVelocity,
                MAX(toInteger(event.velocity)) AS maxVelocity
            SKIP %s
            LIMIT %s
        """, start, end, offset, first);
    }
    private static String buildFindStreetsPageQuery(final int first, final int offset) {
        return String.format("MATCH p=()-[r:MADE_OF]->() RETURN p SKIP %s LIMIT %s",
            offset * STREET_UNIT,
            first * STREET_UNIT);
    }
    private static String buildStreetsPageInfoQuery(final int first, final int offset) {
        return String.format("MATCH p=(s:Street) RETURN COUNT(*) AS totalCount, COUNT(*) - %s > 0 AS hasNextPage", first + offset);
    }

    @Override
    public Multi<StreetEntity> findStreets(final int first, final int offset) {
        return Neo4jReactiveSessions.executeRead(driver, buildFindStreetsPageQuery(first, offset))
            .group()
            .by(StreetRepositoryNeo4j::getStreetIdFromRecord)
            .onItem()
            .transform(group ->
                group.collect()
                    .asList()
                    .map(streetMapper::toStreetEntity))
            .flatMap(Uni::toMulti);
    }

    @Override
    public Multi<StreetTrafficReport> buildStreetTrafficReports(
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return Neo4jReactiveSessions.executeRead(driver, buildTrafficReportsBetweenQuery(first, offset, start, end))
            .onItem()
            .transform(streetMapper::toStreetTrafficReport);
    }

    @Override
    public Uni<StreetsPageInfo> streetsPageInfoFrom(final int first, final int offset) {
        return Neo4jReactiveSessions.executeRead(driver, buildStreetsPageInfoQuery(first, offset))
            .toUni()
            .map(record -> {
                final Value totalCount = record.get(0);
                final Value hasNextPage = record.get(1);
                return new StreetsPageInfo(totalCount.asInt(), first, offset, hasNextPage.asBoolean());
            });
    }

    private static String getStreetIdFromRecord(final Record record) {
        final Value value = record.get(0);
        final Path path = value.asPath();
        final Node streetNode = path.start();
        return streetNode.elementId();
    }
}
