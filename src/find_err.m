function [station, day] = find_err(adj_mat, temp)
    err = abs(adj_mat * temp - temp);
    err = err ./ repmat(sum(err, 2), [1 size(temp, 2)]);

    [~, index] = max(err(:));
    stations = size(temp, 1);
    station = mod(index - 1, stations) + 1;
    day = ceil(index / stations);
end
