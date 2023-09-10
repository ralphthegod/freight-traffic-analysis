package fta.entity;

import org.neo4j.ogm.annotation.EndNode;
import org.neo4j.ogm.annotation.Property;
import org.neo4j.ogm.annotation.RelationshipEntity;
import org.neo4j.ogm.annotation.StartNode;

@RelationshipEntity("MADE_OF")
public class SegmentOrderEntity {
    @StartNode StreetEntity street;
    @EndNode 
    @Property int order;
}
