function countIntegers(n) {
    const memo = {};
    function dfs(target, power) {
        if (target < 0) return 0;
        if (target === 0) return 1;
        if (memo.hasOwnProperty(`${target},${power}`)) return memo[`${target},${power}`];
        let res = 0;
        let i = 1;
        while (true) {
            const val = Math.pow(i, power);
            if (val > target) break;
            res += dfs(target - val, power + 1);
            i++;
        }
        memo[`${target},${power}`] = res;
        return res;
    }
    return dfs(n, 2);
}