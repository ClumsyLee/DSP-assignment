function dis = cal_dis(pos1, pos2)
    R = 6371;

    aa = pos1(1) / 180 * pi;
    ba = pos1(2) / 180 * pi;
    ab = pos2(1) / 180 * pi;
    bb = pos2(2) / 180 * pi;
    dis = R * acos(cos(aa - ab) * cos(ba) * cos(bb) + sin(ba) * sin(bb));
end
