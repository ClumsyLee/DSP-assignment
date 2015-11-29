% Connect k-nearest neighbors.
function adj_mat = cal_adj_mat(dis, k, method)
    len = size(dis, 1);

    if strcmp(method, 'nearest')
        k = 1;
    end

    % Keep k entries for each row.
    for row = 1:len
        this_row = dis(row, :);
        sorted = sort(this_row);
        % Note that sorted(1) is always 0, that is distance to self.
        this_row(this_row > sorted(k + 1)) = 0;
        dis(row, :) = this_row;
    end

    switch method
    case 'nearest'
        adj_mat = dis;
    case 'gauss'
        adj_mat = exp(-dis.^2);
    case 'inverse'
        adj_mat = 1 ./ dis;
    case 'inverse-squared'
        adj_mat = 1 ./ (dis.^2);
    end

    adj_mat(dis == 0) = 0;

    row_sum = sum(adj_mat, 2);
    adj_mat = adj_mat ./ repmat(row_sum, [1 len]);
end
