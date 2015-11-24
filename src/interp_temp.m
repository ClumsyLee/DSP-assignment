function weight_mat = interp_temp(pos, temp, alpha, desired_stations)
    stations = size(pos, 1);
    weight_mat = zeros(stations, stations - 1);

    % Calculate weight matrix.
    for station = 1:stations
        range = (1:stations ~= station);
        x = pos(station, 1);
        y = pos(station, 2);
        w = weight(pos(range, :), [x y], alpha, desired_stations)';
        weight_mat(station, :) = w;

    end

    for kx = 1:grid_size(2)
        x = min_xy(1) + interval * (kx - 1);
        for ky = 1:grid_size(1)
            y = min_xy(2) + interval * (ky - 1);

            w_mat(k, :) = w_mat(k, :) / sum(w_mat(k, :));  % Normalize.
            k = k + 1;
        end
    end

    days = size(temp, 2);
    temp_grid = zeros([grid_size days]);

    for day = 1:days
        temp_grid(:, :, day) = reshape(w_mat * temp(:, day), grid_size);
    end
end

function w = weight(pos, pred_pos, alpha, desired_stations)
    len = size(pos, 1);
    w = zeros(len, 1);

    r = zeros(len, 1);
    for k = 1:len
        r(k) = cal_dis(pos(k, :), pred_pos);
    end

    [value, index] = sort(r);
    non_zeros = index(1:desired_stations);
    rp = value(desired_stations);

    w(non_zeros) = exp(-(r(non_zeros) / rp).^2 * alpha) - exp(-alpha);
end
