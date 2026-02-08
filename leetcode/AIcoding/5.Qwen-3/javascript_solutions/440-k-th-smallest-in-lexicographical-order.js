function findKthNumber(n, k) {
    function countSteps(n, curr, next) {
        let steps = 0;
        while (curr <= n) {
            steps += Math.min(n + 1, next) - curr;
            curr *= 10;
            next *= 10;
        }
        return steps;
    }

    let curr = 1;
    k--;
    while (k > 0) {
        const steps = countSteps(n, curr, curr + 1);
        if (k >= steps) {
            k -= steps;
            curr++;
        } else {
            k--;
            curr *= 10;
        }
    }
    return curr;
}