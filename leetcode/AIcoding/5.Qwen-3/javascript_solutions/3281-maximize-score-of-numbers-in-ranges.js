function maxScore(nums, ranges) {
    const n = nums.length;
    const m = ranges.length;
    const events = [];

    for (let i = 0; i < m; i++) {
        const [start, end] = ranges[i];
        events.push([start, 1, i]);
        events.push([end + 1, -1, i]);
    }

    events.sort((a, b) => a[0] - b[0]);

    const score = new Array(m).fill(0);
    let current = 0;

    for (let i = 0; i < events.length; i++) {
        const [pos, delta, idx] = events[i];
        if (i > 0 && pos > events[i - 1][0]) {
            score[idx] += current * (pos - events[i - 1][0]);
        }
        current += delta;
    }

    const sortedScores = score.slice().sort((a, b) => b - a);
    let res = 0;

    for (let i = 0; i < n; i++) {
        res += sortedScores[i] * nums[i];
    }

    return res;
}