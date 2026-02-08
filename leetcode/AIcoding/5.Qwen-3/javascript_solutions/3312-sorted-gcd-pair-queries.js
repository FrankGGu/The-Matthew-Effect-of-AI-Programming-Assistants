function sortedGcdPairs(nums, queries) {
    const n = nums.length;
    const gcds = [];

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let g = nums[i];
            let h = nums[j];
            while (h) {
                let temp = h;
                h = g % h;
                g = temp;
            }
            gcds.push(g);
        }
    }

    gcds.sort((a, b) => a - b);

    const result = [];
    for (const q of queries) {
        let left = 0, right = gcds.length - 1;
        let ans = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (gcds[mid] <= q) {
                ans = gcds[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result.push(ans);
    }

    return result;
}