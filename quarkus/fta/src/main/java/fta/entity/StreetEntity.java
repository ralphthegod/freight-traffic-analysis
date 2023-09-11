package fta.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class StreetEntity {
    private String uuid;
    private String id;
    private String dataset;
    private List<TimestampEntity> events = new ArrayList<>();
    private List<SegmentEntity> segments = new ArrayList<>();

    public void addEvent(final TimestampEntity timestamp) {
        events.add(timestamp);
    }

    public void addSegment(final SegmentEntity segment) {
        segments.add(segment);
    }
}
