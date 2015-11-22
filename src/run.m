load '../data/data.mat'

dis = cal_dis(data(:, [end, end - 1]));
adj_mat = cal_adj_mat(dis, 6);
draw_adj(data, adj_mat);
