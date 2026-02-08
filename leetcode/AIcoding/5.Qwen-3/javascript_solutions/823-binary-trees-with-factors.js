function numFactoredBinaryTrees(n) {
    arr.sort((a, b) => a - b);
    const mod = 10 ** 9 + 7;
    const map = new Map();
    for (let i = 0; i < arr.length; i++) {
        map.set(arr[i], i);
    }
    const dp = new Array(arr.length).fill(1);
    for (let i = 0; i < arr.length; i++) {
        for (let j = 0; j < i; j++) {
            if (arr[i] % arr[j] === 0) {
                const k = arr[i] / arr[j];
                if (map.has(k)) {
                    dp[i] = (dp[i] + dp[j] * dp[map.get(k)]) % mod;
                }
            }
        }
    }
    return dp.reduce((sum, val) => (sum + val) % mod, 0);
}