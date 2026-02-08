function findMatrix(nums) {
    const count = {};
    const result = [];

    for (const num of nums) {
        if (!count[num]) {
            count[num] = 0;
        }
        count[num]++;
    }

    while (true) {
        const row = [];
        for (const key in count) {
            if (count[key] > 0) {
                row.push(parseInt(key));
                count[key]--;
            }
        }
        if (row.length === 0) break;
        result.push(row);
    }

    return result;
}