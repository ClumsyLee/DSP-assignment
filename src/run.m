load '../data/data.mat'

dis = cal_dis(data(:, [end, end - 1]));

temp = data(:, 2:end-2);
stations = size(temp, 1);
days = size(temp, 2);

method = {'gauss'; 'inverse'; 'inverse-squared'; 'nearest'};

figure;
hold on

for k_method = 1:length(method)
    correct_rate = [];
    for neighbor = 1:20
        adj_mat = cal_adj_mat(dis, neighbor, method{k_method});

        correct = 0;
        for station = 1:stations
            for day = 1:days
                err_temp = temp;
                err_temp(station, day) = err_temp(station, day) + 20;
                [pred_station, pred_day] = find_err(adj_mat, err_temp);

                if pred_station == station && pred_day == day
                    correct = correct + 1;
                end
            end
        end

        correct_rate(neighbor) = correct / (stations * days);
    end
    plot(correct_rate);
end

legend(method);
xlabel neighbors
ylabel 'correct rate'
