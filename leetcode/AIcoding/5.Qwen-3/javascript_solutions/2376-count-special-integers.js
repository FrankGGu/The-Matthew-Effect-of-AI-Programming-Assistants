function countSpecialIntegers(n) {
    const s = n.toString();
    const m = s.length;
    const dp = Array.from({ length: m + 1 }, () => Array(2).fill(0));
    const memo = {};

    function dfs(pos, tight, leadingZeros, cnt) {
        if (pos === m) {
            return cnt > 0 ? 1 : 0;
        }
        const key = `${pos},${tight},${leadingZeros},${cnt}`;
        if (memo[key] !== undefined) {
            return memo[key];
        }

        let limit = tight ? parseInt(s[pos]) : 9;
        let res = 0;

        for (let d = 0; d <= limit; d++) {
            let newTight = tight && (d === limit);
            let newLeadingZeros = leadingZeros && (d === 0);
            let newCnt = cnt;
            if (!newLeadingZeros) {
                if (d === 0) {
                    newCnt++;
                } else {
                    newCnt = 1;
                }
            }
            res += dfs(pos + 1, newTight, newLeadingZeros, newCnt);
        }

        memo[key] = res;
        return res;
    }

    return dfs(0, true, true, 0);
}