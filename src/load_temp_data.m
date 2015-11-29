function data = load_temp_data(daily_file, station_ids)
    daily = readtable(daily_file);
    data = [];

    for id = station_ids'
        row = cellfun(@str2double, daily.Tavg(daily.WBAN == id))';
        id
        size(row)
        data = [data; row];
    end
end
