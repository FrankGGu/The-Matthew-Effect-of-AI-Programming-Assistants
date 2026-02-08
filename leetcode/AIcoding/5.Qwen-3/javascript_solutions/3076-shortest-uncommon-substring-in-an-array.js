function shortestUncommonSubstrings(arr) {
    const n = arr.length;
    const count = new Map();

    for (let i = 0; i < n; i++) {
        const s = arr[i];
        const len = s.length;
        for (let l = 1; l <= len; l++) {
            for (let j = 0; j <= len - l; j++) {
                const sub = s.substring(j, j + l);
                count.set(sub, (count.get(sub) || 0) + 1);
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const s = arr[i];
        const len = s.length;
        for (let l = 1; l <= len; l++) {
            for (let j = 0; j <= len - l; j++) {
                const sub = s.substring(j, j + l);
                if (count.get(sub) === 1) {
                    result.push(sub);
                    return result;
                }
            }
        }
    }

    return result;
}