package fta.repository;

import fta.data.StreetsPageInfo;
import fta.entity.StreetEntity;
import fta.mapper.StreetMapper;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Record;
import org.neo4j.driver.Value;
import org.neo4j.driver.types.Node;
import org.neo4j.driver.types.Path;

@ApplicationScoped
public class StreetRepositoryNeo4j implements StreetRepository {
    @Inject Driver driver;
    @Inject StreetMapper streetMapper;

    private static final int STREET_UNIT = 5;
    private static String buildFindStreetsPageQuery(final String dataset, final int first, final int offset) {
        return String.format("MATCH p=(s:Street)-[r:MADE_OF]->() WHERE s.dataset = '%s' RETURN p SKIP %s LIMIT %s",
            dataset,
            offset * STREET_UNIT,
            first * STREET_UNIT);
    }
    private static String buildStreetsPageInfoQuery(final String dataset, final int first, final int offset) {
        return String.format("""
            MATCH p=(s:Street)
            WHERE s.dataset = '%s'
            RETURN COUNT(*) AS totalCount, COUNT(*) - %s > 0 AS hasNextPage""",
            dataset, first + offset);
    }

    @Override
    public Multi<StreetEntity> findStreets(final String dataset, final int first, final int offset) {
        return Neo4jReactiveSessions.executeRead(driver, buildFindStreetsPageQuery(dataset, first, offset))
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
    public Uni<StreetsPageInfo> streetsPageInfoFrom(final String dataset, final int first, final int offset) {
        return Neo4jReactiveSessions.executeRead(driver, buildStreetsPageInfoQuery(dataset, first, offset))
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
