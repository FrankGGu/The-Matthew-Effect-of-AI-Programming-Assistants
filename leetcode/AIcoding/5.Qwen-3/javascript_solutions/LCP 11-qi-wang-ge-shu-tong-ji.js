function expectedNumbers(nums) {
    const n = nums.length;
    const count = new Array(n + 1).fill(0);
    for (const num of nums) {
        count[num]++;
    }
    let res = 0;
    for (let i = 1; i <= n; i++) {
        if (count[i] === 0) {
            res++;
        }
    }
    return res;
}