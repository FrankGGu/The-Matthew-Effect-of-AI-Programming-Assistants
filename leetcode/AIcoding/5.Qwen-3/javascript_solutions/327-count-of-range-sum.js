function countRangeSum(nums) {
    const sum = [0];
    for (let num of nums) {
        sum.push(sum[sum.length - 1] + num);
    }

    const sorted = [...sum].sort((a, b) => a - b);
    const map = new Map();
    let index = 0;
    for (let s of sorted) {
        if (!map.has(s)) {
            map.set(s, index++);
        }
    }

    const BIT = new Array(index + 1).fill(0);

    function update(i, delta) {
        while (i < BIT.length) {
            BIT[i] += delta;
            i += i & -i;
        }
    }

    function query(i) {
        let res = 0;
        while (i > 0) {
            res += BIT[i];
            i -= i & -i;
        }
        return res;
    }

    let result = 0;
    for (let i = sum.length - 1; i >= 0; i--) {
        const lower = sum[i] - 1;
        const upper = sum[i];
        const left = map.get(lower) + 1;
        const right = map.get(upper);
        result += query(right) - query(left - 1);
        update(map.get(sum[i]) + 1, 1);
    }

    return result;
}