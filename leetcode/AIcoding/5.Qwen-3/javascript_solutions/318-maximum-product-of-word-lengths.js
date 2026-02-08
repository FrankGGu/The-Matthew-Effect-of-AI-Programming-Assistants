function maxProduct(words) {
    const n = words.length;
    const masks = new Array(n);

    for (let i = 0; i < n; i++) {
        let mask = 0;
        for (const c of words[i]) {
            mask |= 1 << (c.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        masks[i] = mask;
    }

    let maxProd = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((masks[i] & masks[j]) === 0) {
                maxProd = Math.max(maxProd, words[i].length * words[j].length);
            }
        }
    }

    return maxProd;
}