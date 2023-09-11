package fta.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StreetTrafficReport {
    private StreetEntity street;
    private int sumTraffic;
    private int maxTraffic;
    private int minTraffic;
    private double avgTraffic;
    private double avgVelocity;
    private double maxVelocity;
}
