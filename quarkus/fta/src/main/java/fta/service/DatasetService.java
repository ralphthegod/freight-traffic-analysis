package fta.service;

import fta.data.DatasetInfo;
import fta.mapper.DatasetMapper;
import fta.repository.DatasetInfoRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class DatasetService {
    @Inject DatasetInfoRepository datasetInfoRepository;
    @Inject DatasetMapper datasetMapper;

    public List<DatasetInfo> getInfoDatasets() {
        if (datasetInfoRepository.isEmpty()) {
            datasetInfoRepository.refreshDatasetInfoMaterializedView();
        }

        return datasetInfoRepository.findAllDatasetInfo()
            .stream()
            .map(datasetMapper::toDataset)
            .toList();
    }
}
