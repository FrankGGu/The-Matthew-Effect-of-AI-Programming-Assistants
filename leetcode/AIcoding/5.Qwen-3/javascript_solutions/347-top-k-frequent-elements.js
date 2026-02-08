function topKFrequent(nums, k) {
    const count = {};
    const buckets = [];
    const result = [];

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const key in count) {
        const freq = count[key];
        if (!buckets[freq]) {
            buckets[freq] = [];
        }
        buckets[freq].push(key);
    }

    for (let i = buckets.length - 1; i >= 0; i--) {
        if (buckets[i]) {
            result.push(...buckets[i]);
            if (result.length === k) break;
        }
    }

    return result;
}