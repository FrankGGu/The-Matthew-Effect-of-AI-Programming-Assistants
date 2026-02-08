function numSubseq(nums, queries) {
    const MOD = 1000000007;
    const n = nums.length;
    const pow2 = new Array(n).fill(1);
    for (let i = 1; i < n; i++) {
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }

    const prefix = new Array(n + 1).fill(1);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = (prefix[i] * nums[i]) % MOD;
    }

    const result = [];
    for (const [l, r] of queries) {
        const len = r - l + 1;
        const res = (prefix[r + 1] * pow2[len - 1]) % MOD;
        result.push(res);
    }

    return result;
}