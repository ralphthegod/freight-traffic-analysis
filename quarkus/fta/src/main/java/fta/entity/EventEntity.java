package fta.entity;

public class EventEntity {
    public static final String COLLECTION_NAME = "traffic_events";
    StreetEntity street;
    TimestampEntity timestamp;
    double traffic;
    double velocity;
}
