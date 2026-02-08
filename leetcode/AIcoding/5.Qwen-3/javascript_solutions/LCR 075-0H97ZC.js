var relativeSort = function(arr1, arr2) {
    const map = {};
    for (let i = 0; i < arr2.length; i++) {
        map[arr2[i]] = i;
    }
    return arr1.sort((a, b) => {
        if (map[a] !== undefined && map[b] !== undefined) {
            return map[a] - map[b];
        } else if (map[a] !== undefined) {
            return -1;
        } else if (map[b] !== undefined) {
            return 1;
        } else {
            return a - b;
        }
    });
};