package fta.data;

import java.util.List;

public record StreetsPage(
    int totalCount,
    List<Street> streets,
    PageInfo pageInfo
) {}
