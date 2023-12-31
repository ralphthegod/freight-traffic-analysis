import datetime
import os
import pandas as pd

def dynamic_to_fixed_size_array(array, size):
    if len(array) == 0 or len(array) <= size:
        return array

    result = [array[0]]
    size -= 2
    step = len(array) // size

    for i in range(size):
        index = i * step % len(array)
        result.append(array[index])

    result.append(array[0])
    return result

def street_to_coords(street):
    # Geometry --> Coordinates --> coords
    coords = dynamic_to_fixed_size_array(street["geometry"]["coordinates"][0], 6)
    return { "coords": coords }

def get_isoformat_date(dt):
    datetime_dict = {}
    datetime_dict['year'] = int(dt[:4])
    datetime_dict['month'] = int(dt[5:7])
    datetime_dict['day'] = int(dt[8:10])
    datetime_dict['hour'] = int(dt[11:13])
    datetime_dict['minute'] = int(dt[14:16])
    d = datetime.datetime(datetime_dict['year'], datetime_dict['month'], datetime_dict['day'], datetime_dict['hour'], datetime_dict['minute'], 0, 0)
    return d

def get_events(group_name, group_data, dataset_name):
    events = []
    events_csv = []
    for index, row in group_data.iterrows():
        event = {
            'metadata': { "streetId": group_name, "dataset": dataset_name },
            'timestamp': get_isoformat_date(row['datetime']),
            'traffic': row['traffic'],
            'velocity': row['velocity']
        }
        event_csv_row = {
            'streetId': dataset_name + '_' + str(group_name),
            'timestamp': get_isoformat_date(row['datetime']),
            'traffic': row['traffic'],
            'velocity': row['velocity']
        }
        events.append(event)
        events_csv.append(event_csv_row)
    return events, events_csv

def get_doc_from_dataframe(grouped_df, dataset_name):
    event_docs = []
    event_csv = []
    i = 0
    for group_name, group_data in grouped_df:
        if pd.isnull(group_name):
            group_name = i

        res, res_csv = get_events(group_name, group_data, dataset_name)
        event_docs.extend(res)
        event_csv.extend(res_csv)
        i = i + 1

    return event_docs, event_csv

def get_docs_from_csv(file, dataset_name):

    df = pd.read_csv(file, header=None)
    df = df.rename(columns={0: 'datetime', 1: 'street_index', 2: 'traffic', 3: 'velocity'})

    int_columns = df.columns[1:]
    df[int_columns] = df[int_columns].astype(int)

    df = df[df['datetime'].notna()]

    df.sort_values(by='street_index', inplace=True)
    grouped_df = df.groupby('street_index')

    event_docs, event_csv = get_doc_from_dataframe(grouped_df, dataset_name)

    event_csv_df = pd.DataFrame(event_csv)
    if os.path.isfile(f"./datasets/output/traffic_events.csv"):
        event_csv_df.to_csv(f"./datasets/output/traffic_events.csv", mode='a', header=False)
    else:
        event_csv_df.to_csv(f"./datasets/output/traffic_events.csv", mode='w', header=True)

    return event_docs


    
    