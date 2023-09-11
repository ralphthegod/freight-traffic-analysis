package fta.data;

public record StreetsPageInfo(
    int totalCount,
    int first,
    int offset,
    boolean hasNextPage
) {}
