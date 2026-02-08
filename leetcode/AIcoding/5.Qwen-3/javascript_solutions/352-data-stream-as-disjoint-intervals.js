var SummaryRanges = function() {
    this.intervals = [];
};

SummaryRanges.prototype.addNum = function(value) {
    const newInterval = [value, value];
    const merged = [];
    let i = 0;

    while (i < this.intervals.length && this.intervals[i][1] < value - 1) {
        merged.push(this.intervals[i]);
        i++;
    }

    while (i < this.intervals.length && this.intervals[i][0] <= value + 1) {
        newInterval[0] = Math.min(newInterval[0], this.intervals[i][0]);
        newInterval[1] = Math.max(newInterval[1], this.intervals[i][1]);
        i++;
    }

    merged.push(newInterval);

    while (i < this.intervals.length) {
        merged.push(this.intervals[i]);
        i++;
    }

    this.intervals = merged;
};

SummaryRanges.prototype.getIntervals = function() {
    return this.intervals;
};