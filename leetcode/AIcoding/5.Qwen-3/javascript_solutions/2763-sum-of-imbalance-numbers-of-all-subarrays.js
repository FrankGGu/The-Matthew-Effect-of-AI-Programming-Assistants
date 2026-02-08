function sumImbalanceNumbers(arr) {
    let n = arr.length;
    let result = 0;

    for (let i = 0; i < n; i++) {
        let max = arr[i];
        let min = arr[i];
        let set = new Set();
        set.add(arr[i]);

        for (let j = i + 1; j < n; j++) {
            if (set.has(arr[j])) {
                result += 0;
                continue;
            }
            set.add(arr[j]);
            max = Math.max(max, arr[j]);
            min = Math.min(min, arr[j]);
            let imbalance = max - min;
            result += imbalance;
        }
    }

    return result;
}