package fta.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SegmentEntity {
    private String uuid;
    @JsonIgnore private StreetEntity street;
    private PositionEntity startCoordinates;
    private PositionEntity endCoordinates;
}
