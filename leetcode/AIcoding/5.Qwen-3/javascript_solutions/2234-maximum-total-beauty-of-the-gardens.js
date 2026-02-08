function maximumTotalBeauty(flowers, newFlowers, people) {
    const n = flowers.length;
    const m = people.length;
    const res = new Array(m).fill(0);
    const sortedPeople = people.map((p, i) => [p, i]).sort((a, b) => a[0] - b[0]);

    const flowerMap = new Map();
    for (let i = 0; i < n; i++) {
        if (!flowerMap.has(flowers[i])) {
            flowerMap.set(flowers[i], []);
        }
        flowerMap.get(flowers[i]).push(i);
    }

    const sortedFlowers = [...flowerMap.keys()].sort((a, b) => a - b);

    const flowerCount = new Map();
    for (const f of sortedFlowers) {
        flowerCount.set(f, flowerMap.get(f).length);
    }

    const flowerIndices = [];
    for (const f of sortedFlowers) {
        for (const idx of flowerMap.get(f)) {
            flowerIndices.push(idx);
        }
    }

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + flowers[flowerIndices[i]];
    }

    const totalFlowerCount = flowerIndices.length;

    for (let i = 0; i < m; i++) {
        const [target, idx] = sortedPeople[i];
        let left = 0;
        let right = n - 1;
        let best = -1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (flowers[flowerIndices[mid]] <= target) {
                best = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (best === -1) {
            res[idx] = 0;
            continue;
        }

        let total = 0;
        let remaining = newFlowers;
        let sum = prefixSum[best + 1];

        for (let j = best; j >= 0 && remaining > 0; j--) {
            const current = flowers[flowerIndices[j]];
            const next = j > 0 ? flowers[flowerIndices[j - 1]] : 0;
            const needed = Math.max(0, target - current);
            if (needed <= remaining) {
                remaining -= needed;
                total += target;
            } else {
                const add = Math.floor(remaining / (j + 1));
                total += (current + add) * (j + 1);
                remaining = 0;
                break;
            }
        }

        if (remaining > 0) {
            const add = Math.floor(remaining / (best + 1));
            total += (flowers[flowerIndices[best]] + add) * (best + 1);
        }

        res[idx] = total;
    }

    return res;
}