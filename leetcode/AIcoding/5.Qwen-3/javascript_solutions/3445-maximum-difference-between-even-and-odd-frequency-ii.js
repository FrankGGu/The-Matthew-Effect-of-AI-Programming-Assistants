var maxEvenOdd = function(nums) {
    let maxDiff = 0;
    let even = 0;
    let odd = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 === 0) {
            even++;
        } else {
            odd++;
        }

        if (even > odd) {
            maxDiff = Math.max(maxDiff, even - odd);
        } else if (odd > even) {
            maxDiff = Math.max(maxDiff, odd - even);
        }
    }

    return maxDiff;
};