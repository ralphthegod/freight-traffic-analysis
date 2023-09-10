package fta.entity;

import org.neo4j.ogm.annotation.NodeEntity;

import java.util.List;

@NodeEntity("Timestamp")
public class TimestampEntity {
    int day;
    int hour;
    int minute;
    int month;
    int year;

    List<StreetEntity> streets;
}
