function numberOfBeautifulIntegers(k) {
    const MOD = 1000000007;
    const dp = Array(2).fill(0).map(() => Array(2).fill(0).map(() => Array(2).fill(0).map(() => Array(100).fill(-1))));

    function dfs(pos, tight, leadingZero, cnt) {
        if (pos === k.length) {
            return leadingZero ? 0 : (cnt % 2 === 0 ? 1 : 0);
        }

        if (dp[pos][tight][leadingZero][cnt] !== -1) {
            return dp[pos][tight][leadingZero][cnt];
        }

        let limit = tight ? parseInt(k[pos]) : 9;
        let res = 0;

        for (let d = 0; d <= limit; d++) {
            let newTight = tight && (d === limit);
            let newLeadingZero = leadingZero && (d === 0);
            let newCnt = cnt;

            if (!newLeadingZero) {
                if (d % 2 === 0) {
                    newCnt++;
                } else {
                    newCnt--;
                }
            }

            if (newCnt < 0) continue;

            res += dfs(pos + 1, newTight, newLeadingZero, newCnt);
            res %= MOD;
        }

        dp[pos][tight][leadingZero][cnt] = res;
        return res;
    }

    return dfs(0, 1, 1, 0);
}