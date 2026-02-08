function maxOperations(nums) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let n = nums.length;
    let dp = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < n - 1; i++) {
        dp[i][i + 1] = 1;
    }

    for (let length = 3; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            let j = i + length - 1;
            let score = nums[i] + nums[j];
            let count = 0;
            if (dp[i + 1][j - 1] > 0) {
                count = dp[i + 1][j - 1] + 1;
            }
            for (let k = i + 1; k < j; k++) {
                if (nums[i] + nums[k] === score && nums[k + 1] + nums[j] === score) {
                    count = Math.max(count, dp[i + 1][k - 1] + dp[k + 1][j - 1] + 1);
                }
            }
            dp[i][j] = count;
        }
    }

    let max = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            max = Math.max(max, dp[i][j]);
        }
    }

    return max;
}