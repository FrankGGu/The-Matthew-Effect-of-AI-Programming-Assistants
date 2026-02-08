var RangeFreqQuery = function(arr) {
    this.map = new Map();
    for (let i = 0; i < arr.length; i++) {
        if (!this.map.has(arr[i])) {
            this.map.set(arr[i], []);
        }
        this.map.get(arr[i]).push(i);
    }
};

RangeFreqQuery.prototype.query = function(left, right, value) {
    const indices = this.map.get(value);
    if (!indices) return 0;

    let low = 0, high = indices.length - 1, l = -1, r = -1;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (indices[mid] >= left) {
            l = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    low = 0; high = indices.length - 1;
    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (indices[mid] <= right) {
            r = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return r - l + 1;
};