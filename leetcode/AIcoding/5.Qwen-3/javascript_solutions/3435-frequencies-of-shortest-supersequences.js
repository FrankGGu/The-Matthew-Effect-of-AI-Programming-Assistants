function numShortestSupersequences(queries) {
    const MOD = 1000000007;
    const dp = {};

    function dfs(s, t) {
        if (s === "" && t === "") return 1;
        if (s === "") return 0;
        if (t === "") return 1;

        const key = s + "," + t;
        if (dp[key] !== undefined) return dp[key];

        let res = 0;
        if (s[0] === t[0]) {
            res += dfs(s.slice(1), t.slice(1));
        } else {
            res += dfs(s.slice(1), t);
            res += dfs(s, t.slice(1));
        }

        dp[key] = res % MOD;
        return dp[key];
    }

    return queries.map(([s, t]) => dfs(s, t));
}