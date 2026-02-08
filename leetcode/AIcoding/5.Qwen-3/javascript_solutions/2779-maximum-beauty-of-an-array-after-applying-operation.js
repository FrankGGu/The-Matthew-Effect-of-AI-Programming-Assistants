function maximumBeauty(nums, k) {
    const events = [];
    for (const num of nums) {
        events.push([num - k, 1]);
        events.push([num + k + 1, -1]);
    }

    events.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    let maxBeauty = 0;
    let currentBeauty = 0;

    for (const [_, delta] of events) {
        currentBeauty += delta;
        maxBeauty = Math.max(maxBeauty, currentBeauty);
    }

    return maxBeauty;
}