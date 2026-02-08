function maximumDistance(arrays) {
    let min1 = Infinity, min2 = Infinity;
    let max1 = -Infinity, max2 = -Infinity;
    let minIndex = -1, maxIndex = -1;

    for (let i = 0; i < arrays.length; i++) {
        const arr = arrays[i];
        const val = arr[0];
        if (val < min1) {
            min2 = min1;
            min1 = val;
            minIndex = i;
        } else if (val < min2) {
            min2 = val;
        }

        const valLast = arr[arr.length - 1];
        if (valLast > max1) {
            max2 = max1;
            max1 = valLast;
            maxIndex = i;
        } else if (valLast > max2) {
            max2 = valLast;
        }
    }

    if (minIndex !== maxIndex) {
        return max1 - min1;
    } else {
        return Math.max(max2 - min1, max1 - min2);
    }
}