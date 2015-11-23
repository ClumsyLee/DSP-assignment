function temp_grid = interp_temp(pos, temp, interval, alpha, desired_stations)
    RP_INIT = 4000;
    ITER = 3;
    avg_w = (1 - exp(-alpha)) / alpha - exp(1);
    len = size(pos, 1);

    min_xy = min(pos);
    max_xy = max(pos);

    grid_size = ceil((max_xy - min_xy) / interval) + [1 1];
    w_mat = zeros(prod(grid_size), len);

    % Calculate weight matrix.
    k = 1;
    for kx = 1:grid_size(1)
        x = min_xy(1) + interval * (kx - 1);
        for ky = 1:grid_size(2)
            y = min_xy(2) + interval * (ky - 1);
            rp = RP_INIT;

            for iter = 1:ITER
                w = weight(pos, temp, [x y], alpha, rp);
                dp = sum(w) / (avg_w * pi * rp^2)
                if iter == ITER
                    n_star = desired_stations;
                else
                    n_star = 2 * desired_stations;
                end
                rp = sqrt(n_star / (dp * pi));
            end

            w_mat(k, :) = weight(pos, temp, [x y], alpha, rp)';
            w_mat(k, :) = w_mat(k, :) / sum(w_mat(k, :));  % Normalize.
            k = k + 1;
        end
    end
    % w_mat

    %
    days = size(temp, 2);
    temp_grid = zeros([grid_size days]);

    for day = 1:days
        temp_grid(:, :, day) = w_mat * temp(:, day);
    end
end

function w = weight(pos, temp, pred_pos, alpha, rp)
    len = size(pos, 1);
    w = zeros(len, 1);

    r = zeros(len, 1);
    for k = 1:len
        r(k) = cal_dis(pos(k, :), pred_pos);
    end

    non_zeros = (r <= rp);
    w(non_zeros) = exp(-(r(non_zeros) / rp).^2 * alpha) - exp(-alpha);
    % w
end
