package fta.mapper;

import fta.data.Position;
import fta.data.Street;
import fta.data.StreetSegment;
import fta.data.StreetTrafficReportData;
import fta.entity.PositionEntity;
import fta.entity.SegmentEntity;
import fta.entity.StreetEntity;
import fta.entity.StreetTrafficReport;
import org.mapstruct.Mapper;
import org.neo4j.driver.Record;
import org.neo4j.driver.Value;
import org.neo4j.driver.types.Node;
import org.neo4j.driver.types.Path;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import static fta.repository.Neo4jEntityFields.*;

@Mapper(componentModel = "jakarta")
public interface StreetMapper {

    default StreetEntity toStreetEntity(final Collection<Record> neo4jRecords) {
        final Iterator<Record> neo4jRecordsIterator = neo4jRecords.iterator();
        if (!neo4jRecordsIterator.hasNext()) throw new IllegalArgumentException();

        final StreetEntity street = new StreetEntity();
        boolean firstIteration = true;
        do {
            final Record record = neo4jRecordsIterator.next();
            final Value value = record.get(0);
            final Path path = value.asPath();

            final Node streetNode = path.start();
            if (firstIteration) {
                street.setUuid(streetNode.elementId());
                street.setId(streetNode.get(STREET_ID_FIELD).asString());
                street.setDataset(streetNode.get(STREET_DATASET_FIELD).asString());
                firstIteration = false;
            }

            final Node segmentNode = path.end();
            final List<Double> startCoordinates = segmentNode.get(SEGMENT_START_COORD_FIELD).asList(Value::asDouble);
            final List<Double> endCoordinates = segmentNode.get(SEGMENT_END_COORD_FIELD).asList(Value::asDouble);
            final SegmentEntity segment = new SegmentEntity();
            segment.setUuid(segmentNode.elementId());
            segment.setStreet(street);
            segment.setStartCoordinates(new PositionEntity(startCoordinates.get(0), startCoordinates.get(1)));
            segment.setEndCoordinates(new PositionEntity(endCoordinates.get(0), endCoordinates.get(1)));
            street.addSegment(segment);
        } while (neo4jRecordsIterator.hasNext());

        return street;
    }

    default StreetTrafficReport toStreetTrafficReport(final Record neo4jRecord) {
        final StreetTrafficReport streetTrafficReport = new StreetTrafficReport();
        streetTrafficReport.setSumTraffic(neo4jRecord.get("sumTraffic").asInt());
        streetTrafficReport.setMaxTraffic(neo4jRecord.get("maxTraffic").asInt());
        streetTrafficReport.setMinTraffic(neo4jRecord.get("minTraffic").asInt());
        streetTrafficReport.setAvgTraffic(neo4jRecord.get("avgTraffic").asDouble());
        streetTrafficReport.setAvgVelocity(neo4jRecord.get("avgVelocity").asDouble());
        streetTrafficReport.setMaxVelocity(neo4jRecord.get("maxVelocity").asDouble());
        final Value value = neo4jRecord.get(0);
        final Node street = value.asNode();
        streetTrafficReport.setStreetUUID(street.elementId());
        return streetTrafficReport;
    }

    Street toStreet(StreetEntity streetEntity);
    StreetSegment toStreetSegment(SegmentEntity segmentEntity);
    Position toPosition(PositionEntity positionEntity);
    StreetTrafficReportData toStreetTrafficReportData(StreetTrafficReport streetTrafficReport);
}
