package fta;

import fta.data.DatasetInfo;
import fta.service.DatasetService;
import jakarta.inject.Inject;
import org.eclipse.microprofile.graphql.GraphQLApi;
import org.eclipse.microprofile.graphql.Query;

import java.util.List;

@GraphQLApi
public class DatasetResource {

    @Inject DatasetService datasetService;

    @Query
    public List<DatasetInfo> getInfoDatasets() {
        return datasetService.getInfoDatasets();
    }
}
