package fta.service;

import fta.data.*;
import fta.entity.StreetEntity;
import fta.entity.StreetTrafficReport;
import fta.entity.StreetTrafficReportsEntity;
import fta.mapper.StreetMapper;
import fta.repository.StreetRepository;
import fta.repository.StreetTrafficReportsRepository;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

@ApplicationScoped
public class StreetService {
    @Inject StreetRepository streetRepository;
    @Inject StreetTrafficReportsRepository streetTrafficReportsRepository;
    @Inject StreetMapper streetMapper;
    @ConfigProperty(name = "fta.streets.events.lower_limit_timestamp")
    ZonedDateTime eventLowerLimitTimestamp;
    @ConfigProperty(name = "fta.streets.events.upper_limit_timestamp")
    ZonedDateTime eventUpperLimitTimestamp;

    public Uni<StreetsPage> getStreets(final String dataset, final int first, final int offset) {
        return streetRepository.findStreets(dataset, first, offset)
            .collect()
            .asList()
            .flatMap(streets ->
                buildStreetsPageInfoFrom(dataset, first, offset)
                    .onItem()
                        .transform(streetsPageInfo -> buildStreetsPage(streets, streetsPageInfo))
            );
    }

    private Uni<StreetsPageInfo> buildStreetsPageInfoFrom(final String dataset, final int first, final int offset) {
        return streetRepository.streetsPageInfoFrom(dataset, first, offset);
    }

    private StreetsPage buildStreetsPage(final List<StreetEntity> streetsEntity, final StreetsPageInfo streetsPageInfo) {
        final int totalCount = streetsPageInfo.totalCount();
        final List<Street> streets = streetsEntity.stream().map(streetMapper::toStreet).toList();
        final PageInfo pageInfo = new PageInfo(streetsPageInfo.first(), streetsPageInfo.offset(), streetsPageInfo.hasNextPage());
        return new StreetsPage(totalCount, streets, pageInfo);
    }

    public Uni<StreetTrafficReportsPage> streetTrafficReports(
        final String dataset,
        final int first,
        final int offset,
        final ZonedDateTime start,
        final ZonedDateTime end
    ) {
        return streetTrafficReportsRepository
            .findByDatasetBetween(dataset, first, offset, start, end)
            .flatMap(optionalStreetTrafficReports ->
                optionalStreetTrafficReports.isPresent()
                    ? Uni.createFrom().item(optionalStreetTrafficReports.get().getStreetTrafficReports())
                    : streetRepository.buildStreetTrafficReports(dataset, first, offset, start, end)
                        .collect()
                        .asList())
            .flatMap(streetTrafficReports ->
                    buildStreetsPageInfoFrom(dataset, first, offset)
                        .onItem()
                            .transform(streetsPageInfo -> buildStreetsTrafficReportPage(streetTrafficReports,
                                    streetsPageInfo,
                                    start,
                                    end)));
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

    public Uni<StreetTrafficReportsPage> streetTrafficGlobalReports(final String dataset, final int first, final int offset) {
        return streetTrafficReports(dataset, first, offset, eventLowerLimitTimestamp, eventUpperLimitTimestamp);
    }
}
