function maxScoreSides(nums) {
    const n = nums.length;
    const score = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const a = nums[i];
        const left = (i + 1) % n;
        const right = (i - 1 + n) % n;
        if (a > nums[left]) {
            score[left]++;
        }
        if (a > nums[right]) {
            score[right]++;
        }
    }

    let maxScore = 0;
    let result = 0;
    for (let i = 0; i < n; i++) {
        if (score[i] > maxScore) {
            maxScore = score[i];
            result = i;
        } else if (score[i] === maxScore) {
            result = Math.min(result, i);
        }
    }

    return result;
}