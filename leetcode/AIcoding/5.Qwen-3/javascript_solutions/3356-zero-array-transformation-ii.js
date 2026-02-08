function minZeroArrayTransformation(nums, cost) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + cost[i - 1];
    }

    let res = 0;
    let totalCost = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] > 0) {
            const need = nums[i];
            const left = i > 0 ? prefix[i - 1] : 0;
            const right = prefix[n - 1] - prefix[i];
            const total = left + right;
            const avg = Math.floor(total / (n - 1));
            if (avg >= need) {
                res += need * cost[i];
                nums[i] = 0;
            } else {
                const diff = need - avg;
                res += avg * cost[i];
                nums[i] -= avg;
                totalCost += diff;
            }
        }
    }

    return res;
}