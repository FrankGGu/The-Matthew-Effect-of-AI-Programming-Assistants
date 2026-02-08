function numSubarrayLCM(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let currentLCM = nums[i];
        if (currentLCM === k) count++;
        for (let j = i + 1; j < nums.length; j++) {
            currentLCM = lcm(currentLCM, nums[j]);
            if (currentLCM === k) count++;
            else if (currentLCM > k) break;
        }
    }
    return count;
}

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

function lcm(a, b) {
    return a * b / gcd(a, b);
}