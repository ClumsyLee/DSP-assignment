function count = draw_adj_mat(data, adj_mat)
    count = 0;
    len = size(adj_mat, 1);
    figure
    hold on
    plot(data(:, end), data(:, end-1), 'x')
    for k1=1:len
        for k2=1:len
            if adj_mat(k1, k2)
                plot(data([k1; k2], end), data([k1; k2], end-1));
                count = count + 1;
            end
        end
    end
end
