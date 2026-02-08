function kSmallestPairs(nums1, nums2, k) {
    const minHeap = [];
    const visited = new Set();

    const pushToHeap = (i, j) => {
        if (i < nums1.length && j < nums2.length) {
            const key = `${i},${j}`;
            if (!visited.has(key)) {
                visited.add(key);
                minHeap.push([nums1[i] + nums2[j], i, j]);
            }
        }
    };

    pushToHeap(0, 0);

    const result = [];

    while (result.length < k && minHeap.length > 0) {
        minHeap.sort((a, b) => a[0] - b[0]);
        const [sum, i, j] = minHeap.shift();
        result.push([nums1[i], nums2[j]]);
        pushToHeap(i + 1, j);
        pushToHeap(i, j + 1);
    }

    return result;
}