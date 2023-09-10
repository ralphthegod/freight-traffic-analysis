package fta.entity;

import org.neo4j.ogm.annotation.NodeEntity;

@NodeEntity("Segment")
public class SegmentEntity {
    Double[] startCoordinates;
    Double[] endCoordinates;
}
