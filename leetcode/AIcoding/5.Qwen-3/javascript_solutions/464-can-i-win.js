function canIWin(maxChoosableInteger, desiredTotal) {
    const memo = {};

    function dfs(used, total) {
        const key = used + ',' + total;
        if (memo.hasOwnProperty(key)) {
            return memo[key];
        }

        for (let i = 1; i <= maxChoosableInteger; i++) {
            if ((used & (1 << (i - 1))) === 0) {
                if (total + i >= desiredTotal) {
                    memo[key] = true;
                    return true;
                }
                if (!dfs(used | (1 << (i - 1)), total + i)) {
                    memo[key] = true;
                    return true;
                }
            }
        }

        memo[key] = false;
        return false;
    }

    return dfs(0, 0);
}