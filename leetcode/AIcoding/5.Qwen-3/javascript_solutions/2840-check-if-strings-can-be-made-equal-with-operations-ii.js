function equalizeStrings(s, t) {
    const count = (str) => {
        const freq = new Array(26).fill(0);
        for (const c of str) {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return freq;
    };

    const sFreq = count(s);
    const tFreq = count(t);

    for (let i = 0; i < 26; i++) {
        if (sFreq[i] !== tFreq[i]) return false;
    }

    return true;
}