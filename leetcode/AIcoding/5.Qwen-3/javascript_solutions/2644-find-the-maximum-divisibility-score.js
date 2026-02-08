function maxDivScore(nums, divisors) {
    let maxScore = -1;
    let result = divisors[0];

    for (let d of divisors) {
        let score = 0;
        for (let num of nums) {
            if (num % d === 0) {
                score++;
            }
        }
        if (score > maxScore || (score === maxScore && d < result)) {
            maxScore = score;
            result = d;
        }
    }

    return result;
}