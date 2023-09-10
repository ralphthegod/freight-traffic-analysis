package fta.entity;

import org.neo4j.ogm.annotation.EndNode;
import org.neo4j.ogm.annotation.Property;
import org.neo4j.ogm.annotation.RelationshipEntity;
import org.neo4j.ogm.annotation.StartNode;

@RelationshipEntity(type = "HAS_EVENT")
public class EventEntity {
    @StartNode StreetEntity street;
    @EndNode TimestampEntity timestamp;
    @Property double traffic;
    @Property double velocity;
}
