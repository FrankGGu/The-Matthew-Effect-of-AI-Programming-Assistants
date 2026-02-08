function shiftingLetters(s, shifts) {
    const MOD = 26;
    const n = s.length;
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < shifts.length; i++) {
        const [start, end, amount] = shifts[i];
        prefix[start] += amount;
        prefix[end + 1] -= amount;
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        total += prefix[i];
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const shifted = (charCode + total) % MOD;
        s = s.substring(0, i) + String.fromCharCode('a'.charCodeAt(0) + shifted) + s.substring(i + 1);
    }

    return s;
}