package fta.mapper;

import fta.data.DatasetInfo;
import fta.entity.DatasetInfoEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "jakarta")
public interface DatasetMapper {

    DatasetInfo toDataset(DatasetInfoEntity datasetInfoEntity);
}
