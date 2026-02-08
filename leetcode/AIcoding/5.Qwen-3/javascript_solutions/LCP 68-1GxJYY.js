function beautifulBouquet(roses, k) {
    const MOD = 1000000007;
    const n = roses.length;
    const cnt = new Array(100001).fill(0);
    let res = 0;
    let left = 0;
    for (let right = 0; right < n; right++) {
        cnt[roses[right]]++;
        while (cnt[roses[right]] > k) {
            cnt[roses[left]]--;
            left++;
        }
        res = (res + right - left + 1) % MOD;
    }
    return res;
}