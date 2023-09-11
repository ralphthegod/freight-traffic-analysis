package fta.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TimestampEntity {
    private int day;
    private int hour;
    private int minute;
    private int month;
    private int year;
    private List<StreetEntity> streets;
}
