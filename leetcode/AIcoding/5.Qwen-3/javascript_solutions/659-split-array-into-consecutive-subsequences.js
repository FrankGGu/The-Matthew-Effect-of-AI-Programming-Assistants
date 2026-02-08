function isPossible(nums) {
    const count = {};
    const appendable = {};

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const num of nums) {
        if (count[num] === 0) continue;
        if (appendable[num]) {
            appendable[num]--;
            if (appendable[num] === 0) delete appendable[num];
            count[num]--;
            appendable[num + 1] = (appendable[num + 1] || 0) + 1;
        } else {
            if (count[num + 1] && count[num + 2]) {
                count[num]--;
                count[num + 1]--;
                count[num + 2]--;
                appendable[num + 3] = (appendable[num + 3] || 0) + 1;
            } else {
                return false;
            }
        }
    }

    return true;
}