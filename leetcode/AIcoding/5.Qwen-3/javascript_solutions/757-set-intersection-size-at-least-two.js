function intersectionSizeOne(intervals) {
    intervals.sort((a, b) => a[1] - b[1]);
    let res = 0;
    let last = -1;
    let secondLast = -1;
    for (const [start, end] of intervals) {
        if (start > secondLast) {
            res += 2;
            secondLast = end;
            last = end;
        } else if (start > last) {
            res += 1;
            last = end;
        }
    }
    return res;
}