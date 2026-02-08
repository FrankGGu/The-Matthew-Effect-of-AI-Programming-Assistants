function mirrorScore(s) {
    let score = 0;
    const n = s.length;
    for (let i = 0; i < n / 2; i++) {
        if (s[i] === s[n - 1 - i]) {
            score++;
        }
    }
    return score;
}