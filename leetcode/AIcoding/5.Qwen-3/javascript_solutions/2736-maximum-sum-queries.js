function maximumSumQueries(nums, queries) {
    const n = nums.length;
    const m = queries.length;
    const res = new Array(m).fill(0);
    const sortedQueries = queries.map((q, i) => [q[0], q[1], i]).sort((a, b) => a[0] - b[0]);
    const stack = [];
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[i] >= nums[stack[stack.length - 1]]) {
            stack.pop();
        }
        stack.push(i);
    }
    let j = 0;
    for (let i = 0; i < m; i++) {
        const [x, y, idx] = sortedQueries[i];
        while (j < stack.length && nums[stack[j]] < x) {
            j++;
        }
        if (j < stack.length) {
            res[idx] = nums[stack[j]];
        } else {
            res[idx] = -1;
        }
    }
    return res;
}