function findTheString(strs) {
    const n = strs.length;
    const lcp = Array(n).fill().map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            let k = 0;
            while (k < Math.min(strs[i].length, strs[j].length) && strs[i][k] === strs[j][k]) {
                k++;
            }
            lcp[i][j] = k;
        }
    }

    const result = [];
    for (let i = 0; i < strs[0].length; i++) {
        let c = strs[0][i];
        for (let j = 1; j < n; j++) {
            if (lcp[0][j] > i && strs[j][i] !== c) {
                return "";
            }
        }
        result.push(c);
    }

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (lcp[i][j] !== lcp[j][i]) return "";
            if (lcp[i][j] < result.length && strs[i][lcp[i][j]] !== strs[j][lcp[i][j]]) return "";
        }
    }

    return result.join("");
}