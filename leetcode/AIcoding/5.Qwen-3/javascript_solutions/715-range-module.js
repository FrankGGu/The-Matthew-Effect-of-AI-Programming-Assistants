var RangeModule = function() {
    this.intervals = [];
};

RangeModule.prototype.add = function(left, right) {
    let newIntervals = [];
    let i = 0;
    while (i < this.intervals.length && this.intervals[i][1] < left) {
        newIntervals.push(this.intervals[i]);
        i++;
    }
    while (i < this.intervals.length && this.intervals[i][0] <= right) {
        left = Math.min(left, this.intervals[i][0]);
        right = Math.max(right, this.intervals[i][1]);
        i++;
    }
    newIntervals.push([left, right]);
    while (i < this.intervals.length) {
        newIntervals.push(this.intervals[i]);
        i++;
    }
    this.intervals = newIntervals;
};

RangeModule.prototype.remove = function(left, right) {
    let newIntervals = [];
    for (let interval of this.intervals) {
        if (interval[1] < left || interval[0] > right) {
            newIntervals.push(interval);
        } else {
            if (interval[0] < left) {
                newIntervals.push([interval[0], left]);
            }
            if (interval[1] > right) {
                newIntervals.push([right, interval[1]]);
            }
        }
    }
    this.intervals = newIntervals;
};

RangeModule.prototype.query = function(left, right) {
    for (let interval of this.intervals) {
        if (interval[0] <= left && interval[1] >= right) {
            return true;
        }
    }
    return false;
};