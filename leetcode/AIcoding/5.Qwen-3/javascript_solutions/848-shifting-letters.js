function shiftingLetters(s, shifts) {
    const MOD = 26;
    const n = s.length;
    const totalShifts = new Array(n).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        totalShifts[i] = (totalShifts[i] + shifts[i]) % MOD;
        if (i > 0) {
            totalShifts[i - 1] = (totalShifts[i - 1] + totalShifts[i]) % MOD;
        }
    }

    let result = '';
    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const shiftedCharCode = (charCode + totalShifts[i]) % MOD;
        result += String.fromCharCode(shiftedCharCode + 'a'.charCodeAt(0));
    }

    return result;
}