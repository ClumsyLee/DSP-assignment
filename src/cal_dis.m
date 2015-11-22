function dis = cal_dis(pos)
    R = 6.371;

    len = length(pos);
    dis = zeros(len);

    for k1 = 1:len-1
        for k2 = k1+1:len
            aa = pos(k1, 1) / 180 * pi;
            ba = pos(k1, 2) / 180 * pi;
            ab = pos(k2, 1) / 180 * pi;
            bb = pos(k2, 2) / 180 * pi;
            dis(k1, k2) = ...
                R * acos(cos(aa - ab) * cos(ba) * cos(bb) + sin(ba) * sin(bb));
        end
    end

    dis = dis + dis';
end
