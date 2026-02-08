function kSubarrays(nums, k, m) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    const getSum = (i, j) => prefix[j] - prefix[i];

    const minHeap = [];
    const maxHeap = [];

    for (let i = 0; i <= n - m; i++) {
        const sum = getSum(i, i + m);
        minHeap.push([sum, i]);
        maxHeap.push([-sum, i]);
    }

    for (let i = 0; i < minHeap.length; i++) {
        minHeap[i][0] = -minHeap[i][0];
    }
    for (let i = 0; i < maxHeap.length; i++) {
        maxHeap[i][0] = -maxHeap[i][0];
    }

    function heapify(arr, i, size) {
        let smallest = i;
        const left = 2 * i + 1;
        const right = 2 * i + 2;
        if (left < size && arr[left][0] < arr[smallest][0]) smallest = left;
        if (right < size && arr[right][0] < arr[smallest][0]) smallest = right;
        if (smallest !== i) {
            [arr[i], arr[smallest]] = [arr[smallest], arr[i]];
            heapify(arr, smallest, size);
        }
    }

    function buildHeap(arr) {
        for (let i = Math.floor(arr.length / 2) - 1; i >= 0; i--) {
            heapify(arr, i, arr.length);
        }
    }

    buildHeap(minHeap);
    buildHeap(maxHeap);

    const result = [];

    for (let i = 0; i < k; i++) {
        const minVal = minHeap[0][0];
        const minStart = minHeap[0][1];
        result.push(minVal);
        minHeap[0] = minHeap[minHeap.length - 1];
        minHeap.pop();
        heapify(minHeap, 0, minHeap.length);

        const maxVal = maxHeap[0][0];
        const maxStart = maxHeap[0][1];
        result.push(maxVal);
        maxHeap[0] = maxHeap[maxHeap.length - 1];
        maxHeap.pop();
        heapify(maxHeap, 0, maxHeap.length);
    }

    return result.reduce((a, b) => a + b, 0);
}