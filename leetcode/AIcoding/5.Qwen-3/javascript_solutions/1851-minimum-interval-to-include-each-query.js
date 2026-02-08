function minInterval(intervals, queries) {
    intervals.sort((a, b) => a[0] - b[0]);
    const sortedQueries = [...queries].sort((a, b) => a - b);
    const result = {};
    const heap = [];

    let i = 0;
    for (const q of sortedQueries) {
        while (i < intervals.length && intervals[i][0] <= q) {
            const [start, end] = intervals[i];
            const length = end - start + 1;
            heap.push([length, end]);
            heap.sort((a, b) => a[0] - b[0]);
            i++;
        }

        while (heap.length > 0 && heap[0][1] < q) {
            heap.shift();
        }

        if (heap.length > 0) {
            result[q] = heap[0][0];
        } else {
            result[q] = -1;
        }
    }

    return queries.map(q => result[q]);
}