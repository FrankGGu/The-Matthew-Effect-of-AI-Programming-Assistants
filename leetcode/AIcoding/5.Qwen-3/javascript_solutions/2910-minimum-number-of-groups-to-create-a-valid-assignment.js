function minGroups(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const freqs = Object.values(count).sort((a, b) => b - a);
    const maxFreq = freqs[0];

    let left = 1;
    let right = maxFreq;

    const isValid = (k) => {
        let groups = 0;
        for (const f of freqs) {
            const q = Math.floor(f / k);
            const r = f % k;
            if (r !== 0) {
                groups += q + 1;
            } else {
                groups += q;
            }
        }
        return groups;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const res = isValid(mid);
        if (res <= maxFreq) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return isValid(left);
}