% Connect k-nearest neighbors.
function adj_mat = cal_adj_mat(dis, k)
    len = size(dis, 1);

    % Keep k entries for each row.
    for row = 1:len
        this_row = dis(row, :);
        sorted = sort(this_row);
        % Note that sorted(1) is always 0, that is distance to self.
        this_row(this_row > sorted(k + 1)) = 0;
        dis(row, :) = this_row;
    end

    adj_mat = exp(-dis.^2);
    adj_mat(dis == 0) = 0;

    row_sum = sum(adj_mat')';

    for row = 1:len
        for col = 1:len
            if adj_mat(row, col) ~= 0
                adj_mat(row, col) = adj_mat(row, col) / sqrt(row_sum(row) * row_sum(col));
            end
        end
    end
end
