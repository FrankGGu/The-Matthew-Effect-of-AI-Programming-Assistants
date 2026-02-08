function findAnagrams(s, p) {
    const result = [];
    const pCount = new Array(26).fill(0);
    const sCount = new Array(26).fill(0);
    const lenP = p.length;
    const lenS = s.length;

    if (lenP > lenS) return result;

    for (let i = 0; i < lenP; i++) {
        pCount[p.charCodeAt(i) - 97]++;
    }

    for (let i = 0; i < lenP; i++) {
        sCount[s.charCodeAt(i) - 97]++;
    }

    if (pCount.toString() === sCount.toString()) {
        result.push(0);
    }

    for (let i = lenP; i < lenS; i++) {
        sCount[s.charCodeAt(i - lenP) - 97]--;
        sCount[s.charCodeAt(i) - 97]++;
        if (pCount.toString() === sCount.toString()) {
            result.push(i - lenP + 1);
        }
    }

    return result;
}