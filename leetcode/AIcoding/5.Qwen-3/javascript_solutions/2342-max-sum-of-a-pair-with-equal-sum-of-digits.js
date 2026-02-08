function maximumSum(nums) {
    const map = new Map();
    let maxSum = -1;

    for (const num of nums) {
        let sum = 0;
        let n = num;
        while (n > 0) {
            sum += n % 10;
            n = Math.floor(n / 10);
        }

        if (map.has(sum)) {
            maxSum = Math.max(maxSum, map.get(sum) + num);
        } else {
            map.set(sum, num);
        }
    }

    return maxSum;
}