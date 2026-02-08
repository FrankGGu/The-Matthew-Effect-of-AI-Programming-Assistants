var CountIntegersInIntervals = function () {
    this.intervals = [];
};

CountIntegersInIntervals.prototype.add = function (start, end) {
    this.intervals.push([start, end]);
    this.intervals.sort((a, b) => a[0] - b[0]);
    let merged = [];
    for (let interval of this.intervals) {
        if (!merged.length || merged[merged.length - 1][1] < interval[0] - 1) {
            merged.push(interval);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], interval[1]);
        }
    }
    this.intervals = merged;
};

CountIntegersInIntervals.prototype.count = function () {
    let count = 0;
    for (let [start, end] of this.intervals) {
        count += end - start + 1;
    }
    return count;
};