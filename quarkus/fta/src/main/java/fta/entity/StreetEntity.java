package fta.entity;

import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.List;

@NodeEntity("Street")
public class StreetEntity {
    String id;
    String dataset;

    @Relationship(type = "HAS_EVENT")
    List<TimestampEntity> events;

    @Relationship(type = "MADE_OF")
    List<SegmentEntity> segments;
}
