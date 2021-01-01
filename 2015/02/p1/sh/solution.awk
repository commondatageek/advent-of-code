function min_side(sd_1, sd_2, sd_3) {
    min_sd = sd_1
    if (sd_2 < min_sd) {
        min_sd = sd_2
    }
    if (sd_3 < min_sd) {
        min_sd = sd_3
    }
    return min_sd
}

BEGIN {
    total_sq_ft=0
}

{
    ln = $1
    wd = $2
    ht = $3

    sd_1 = ln * wd
    sd_2 = ln * ht
    sd_3 = wd * ht

    needed = 2 * sd_1 + 2 * sd_2 + 2 * sd_3
    extra = min_side(sd_1, sd_2, sd_3)

    total_sq_ft = total_sq_ft + needed + extra
}

END {
    print(total_sq_ft)
}
