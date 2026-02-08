function minOperations(target, arr) {
    let count = 0;
    let i = 0;
    while (i < target.length) {
        if (arr[i] === target[i]) {
            i++;
        } else {
            let j = i + 1;
            while (j < arr.length && arr[j] !== target[i]) {
                j++;
            }
            if (j < arr.length) {
                for (let k = j; k > i; k--) {
                    [arr[k], arr[k - 1]] = [arr[k - 1], arr[k]];
                }
                count++;
                i++;
            } else {
                return -1;
            }
        }
    }
    return count;
}