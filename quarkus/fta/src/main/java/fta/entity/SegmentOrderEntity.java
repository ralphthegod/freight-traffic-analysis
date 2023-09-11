package fta.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SegmentOrderEntity {
    private String uuid;
    private StreetEntity street;
    private SegmentEntity segment;
    private int order;
}
