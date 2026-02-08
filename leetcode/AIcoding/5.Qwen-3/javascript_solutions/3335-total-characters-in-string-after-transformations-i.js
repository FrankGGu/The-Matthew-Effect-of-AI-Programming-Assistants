function findMaximumElegance(s, queries, masks) {
    const n = s.length;
    const m = queries.length;
    const result = new Array(m).fill(0);
    const charCount = new Array(26).fill(0);
    const freq = new Array(26).fill(0);
    const pos = new Array(26).fill(0);

    for (let i = 0; i < n; ++i) {
        const c = s[i].charCodeAt(0) - 'a'.charCodeAt(0);
        charCount[c]++;
    }

    for (let i = 0; i < m; ++i) {
        const q = queries[i];
        const mask = masks[i];
        const len = mask.length;
        const temp = new Array(26).fill(0);
        for (let j = 0; j < len; ++j) {
            const c = mask[j].charCodeAt(0) - 'a'.charCodeAt(0);
            temp[c]++;
        }

        for (let j = 0; j < 26; ++j) {
            if (temp[j] > 0) {
                freq[j] = temp[j];
            }
        }

        let total = 0;
        for (let j = 0; j < 26; ++j) {
            if (freq[j] > 0) {
                total += Math.min(charCount[j], freq[j]);
            }
        }

        result[i] = total;
    }

    return result;
}