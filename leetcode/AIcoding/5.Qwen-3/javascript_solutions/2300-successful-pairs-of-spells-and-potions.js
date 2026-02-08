function successfulPairs(spells, potions, success) {
    const n = spells.length;
    const m = potions.length;
    const result = new Array(n).fill(0);
    potions.sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        const s = spells[i];
        let left = 0;
        let right = m - 1;
        let count = 0;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (s * potions[mid] >= success) {
                count = m - mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result[i] = count;
    }

    return result;
}