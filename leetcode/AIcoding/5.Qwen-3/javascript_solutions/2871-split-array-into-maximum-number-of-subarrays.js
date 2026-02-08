function maxSubarrays(nums) {
    let count = 0;
    let currentSum = 0;
    for (let num of nums) {
        currentSum += num;
        if (currentSum === 0) {
            count++;
            currentSum = 0;
        }
    }
    return count;
}