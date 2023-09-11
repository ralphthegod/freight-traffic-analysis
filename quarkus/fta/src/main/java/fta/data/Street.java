package fta.data;

import java.util.List;

public record Street(
    String uuid,
    String dataset,
    String id,
    List<StreetSegment> segments
) {}
