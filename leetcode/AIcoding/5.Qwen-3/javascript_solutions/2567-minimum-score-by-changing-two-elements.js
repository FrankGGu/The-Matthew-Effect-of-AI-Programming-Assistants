function minimumScore(nums) {
    const n = nums.length;
    const sorted = [...nums].sort((a, b) => a - b);
    let minScore = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const target = sorted[i] + sorted[j];
            let left = 0;
            let right = n - 1;
            let best = -1;
            while (left <= right) {
                const mid = Math.floor((left + right) / 2);
                if (sorted[mid] <= target) {
                    best = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (best !== -1 && best !== i && best !== j) {
                minScore = Math.min(minScore, Math.abs(target - sorted[best]));
            }
        }
    }

    return minScore;
}