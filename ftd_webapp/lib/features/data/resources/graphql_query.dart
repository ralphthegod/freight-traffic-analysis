mixin GqlQuery{

  static String getStreetsQuery = '''
      query Streets(\$first: Int!, \$offset: Int!, \$dataset: String!) {
        streetsPage(first: \$first, offset: \$offset, dataset: \$dataset) {
          totalCount
          streets {
            uuid
            id
            dataset
            segments {
              startCoordinates {
                latitude
                longitude
              }
              endCoordinates { 
                latitude
                longitude
              }
            }
          }
          pageInfo {
            first
            offset
            hasNextPage
          }
        }
      }
    ''';

  static String getStreetTrafficReportsQuery = '''
      query StreetTrafficReports(\$first: Int!, \$offset: Int!, \$start: DateTime, \$end: DateTime, \$dataset: String!,){
        streetTrafficReports(first: \$first, offset: \$offset, start: \$start, end: \$end, dataset: \$dataset ){
          start
          end
          totalCount
          pageInfo{
            offset
            first
            hasNextPage
          }
          streetTrafficReports{
            streetUUID
            maxTraffic
            avgVelocity
            avgTraffic
            maxVelocity
            minTraffic
            sumTraffic
          }
        }
      }
    ''';

    static String getDatasetsInfoQuery = '''
      query {
          infoDatasets {
            name
            totalStreets
            totalEvents
        }
      }
      ''';

      static String getGlobalStreetTrafficReportsQuery = '''
        query streetTrafficGlobalReports(\$dataset: String!, \$first: Int!, \$offset: Int!) {
          streetTrafficGlobalReports(dataset: \$dataset, first: \$first, offset: \$offset) {
            totalCount
            streetTrafficReports {
              maxTraffic
              avgVelocity
              avgTraffic
              maxVelocity
              minTraffic
              sumTraffic
              streetUUID
            }
            pageInfo {
              first
              offset
              hasNextPage
            }
          }
        }
      ''';
    
}