package fta.entity;

import io.quarkus.mongodb.panache.PanacheMongoEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StreetTrafficReport extends PanacheMongoEntity {
    private String streetUUID;
    private int sumTraffic;
    private int maxTraffic;
    private int minTraffic;
    private double avgTraffic;
    private double avgVelocity;
    private double maxVelocity;
}
