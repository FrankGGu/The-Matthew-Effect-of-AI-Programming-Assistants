var TimeMap = function() {
    this.map = {};
};

TimeMap.prototype.set = function(key, value, timestamp) {
    if (!this.map[key]) {
        this.map[key] = [];
    }
    this.map[key].push([timestamp, value]);
};

TimeMap.prototype.get = function(key, timestamp) {
    if (!this.map[key]) {
        return "";
    }
    let arr = this.map[key];
    let left = 0;
    let right = arr.length - 1;
    let result = "";
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (arr[mid][0] <= timestamp) {
            result = arr[mid][1];
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
};