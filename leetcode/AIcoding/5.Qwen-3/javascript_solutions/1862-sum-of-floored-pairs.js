function sumOfFlooredPairs(nums) {
    const MOD = 10 ** 9 + 7;
    const maxNum = Math.max(...nums);
    const freq = new Array(maxNum + 1).fill(0);
    for (const num of nums) {
        freq[num]++;
    }

    const count = new Array(maxNum + 1).fill(0);
    for (let i = 1; i <= maxNum; i++) {
        for (let j = i; j <= maxNum; j += i) {
            count[j] += freq[i];
        }
    }

    let result = 0;
    for (let i = 1; i <= maxNum; i++) {
        if (freq[i] === 0) continue;
        for (let j = i; j <= maxNum; j += i) {
            result = (result + freq[i] * count[j]) % MOD;
        }
    }

    return result;
}