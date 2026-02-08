function removeBoxes(boxes) {
    const n = boxes.length;
    const memo = Array(n).fill().map(() => Array(n).fill().map(() => Array(n + 1).fill(-1)));

    function dp(l, r, k) {
        if (l > r) return 0;
        if (memo[l][r][k] !== -1) return memo[l][r][k];

        let res = dp(l + 1, r, 0) + (k + 1) * (k + 1);
        for (let i = l + 1; i <= r; i++) {
            if (boxes[i] === boxes[l]) {
                res = Math.max(res, dp(l + 1, i - 1, 0) + dp(i, r, k + 1));
            }
        }

        memo[l][r][k] = res;
        return res;
    }

    return dp(0, n - 1, 0);
}