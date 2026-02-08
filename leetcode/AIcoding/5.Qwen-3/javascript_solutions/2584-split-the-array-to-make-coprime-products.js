function isCoprime(nums) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let product = 1;
    for (let i = 0; i < nums.length; i++) {
        product *= nums[i];
        if (product === 1) continue;
        let left = 1;
        for (let j = 0; j < i; j++) {
            left *= nums[j];
        }
        let right = 1;
        for (let j = i + 1; j < nums.length; j++) {
            right *= nums[j];
        }
        if (gcd(left, right) === 1) {
            return true;
        }
    }
    return false;
}