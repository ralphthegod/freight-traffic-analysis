package fta;

import fta.data.StreetsPage;
import fta.data.StreetTrafficReportsPage;
import fta.service.StreetService;
import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import org.eclipse.microprofile.graphql.DefaultValue;
import org.eclipse.microprofile.graphql.GraphQLApi;
import org.eclipse.microprofile.graphql.Query;

import java.time.ZonedDateTime;

@GraphQLApi
public class StreetResource {

    @Inject StreetService streetService;

    @Query
    public Uni<StreetsPage> getStreets(
        final int first,
        @DefaultValue(value = "0") final Integer offset
    ) {
        return streetService.getStreets(first, offset);
    }

    @Query
    public Uni<StreetTrafficReportsPage> getStreetTrafficReports(
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return streetService.streetTrafficReport(first, offset, start, end);
    }
}
