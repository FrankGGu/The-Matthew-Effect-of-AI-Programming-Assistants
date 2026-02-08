var findPaths = function(m, n, N, x, y) {
    const MOD = 1000000007;
    const memo = {};
    const directions = [[-1,0],[1,0],[0,-1],[0,1]];

    function dfs(i, j, k) {
        if (i < 0 || i >= m || j < 0 || j >= n) {
            return 1;
        }
        if (k === N) {
            return 0;
        }
        const key = `${i},${j},${k}`;
        if (memo.hasOwnProperty(key)) {
            return memo[key];
        }
        let res = 0;
        for (const [dx, dy] of directions) {
            res = (res + dfs(i + dx, j + dy, k + 1)) % MOD;
        }
        memo[key] = res;
        return res;
    }

    return dfs(x, y, 0);
};