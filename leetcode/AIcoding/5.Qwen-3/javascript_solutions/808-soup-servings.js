var soupServings = function(n) {
    const memo = {};

    function dp(a, b) {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1.0;
        if (b <= 0) return 0.0;
        const key = `${a},${b}`;
        if (memo[key] !== undefined) return memo[key];

        const prob = 0.25 * (
            dp(a - 1, b - 1) +
            dp(a - 2, b - 1) +
            dp(a - 1, b - 2) +
            dp(a - 2, b - 2)
        );
        memo[key] = prob;
        return prob;
    }

    return dp(n, n);
};