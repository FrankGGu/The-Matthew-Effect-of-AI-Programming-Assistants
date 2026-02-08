function minimizeOr(nums) {
    let result = 0;
    for (let i = 0; i < 30; i++) {
        let cnt = 0;
        for (const num of nums) {
            if ((num >> i) & 1) {
                cnt++;
            }
        }
        if (cnt > 1) {
            result |= (1 << i);
        }
    }
    return result;
}