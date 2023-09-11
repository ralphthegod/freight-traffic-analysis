package fta.service;

import fta.data.*;
import fta.entity.StreetEntity;
import fta.entity.StreetTrafficReport;
import fta.mapper.StreetMapper;
import fta.repository.StreetRepository;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.ZonedDateTime;
import java.util.List;

@ApplicationScoped
public class StreetService {
    @Inject StreetRepository streetRepository;
    @Inject StreetMapper streetMapper;

    public Uni<StreetsPage> getStreets(int first, int offset) {
        return streetRepository.findStreets(first, offset)
            .collect()
            .asList()
            .flatMap(streets ->
                buildStreetsPageInfoFrom(first, offset)
                    .onItem()
                        .transform(streetsPageInfo -> buildStreetsPage(streets, streetsPageInfo))
            );
    }

    private Uni<StreetsPageInfo> buildStreetsPageInfoFrom(final int first, final int offset) {
        return streetRepository.streetsPageInfoFrom(first, offset);
    }

    private StreetsPage buildStreetsPage(final List<StreetEntity> streetsEntity, final StreetsPageInfo streetsPageInfo) {
        final int totalCount = streetsPageInfo.totalCount();
        final List<Street> streets = streetsEntity.stream().map(streetMapper::toStreet).toList();
        final PageInfo pageInfo = new PageInfo(streetsPageInfo.first(), streetsPageInfo.offset(), streetsPageInfo.hasNextPage());
        return new StreetsPage(totalCount, streets, pageInfo);
    }

    public Uni<StreetTrafficReportsPage> streetTrafficReport(
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return streetRepository.buildStreetTrafficReports(first, offset, start, end)
            .collect()
            .asList()
            .flatMap(streetTrafficReports ->
                buildStreetsPageInfoFrom(first, offset)
                    .onItem()
                        .transform(streetsPageInfo -> buildStreetsTrafficReportPage(streetTrafficReports,
                                    streetsPageInfo,
                                    start,
                                    end))
            );
    }

    private StreetTrafficReportsPage buildStreetsTrafficReportPage(
        final List<StreetTrafficReport> streetTrafficReports,
        final StreetsPageInfo streetsPageInfo,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        final int totalCount = streetsPageInfo.totalCount();
        final List<StreetTrafficReportData> streetTrafficReportsData = streetTrafficReports.stream()
            .map(streetMapper::toStreetTrafficReportData)
            .toList();
        final PageInfo pageInfo = new PageInfo(streetsPageInfo.first(), streetsPageInfo.offset(), streetsPageInfo.hasNextPage());
        return new StreetTrafficReportsPage(start, end, totalCount, streetTrafficReportsData, pageInfo);
    }
}
