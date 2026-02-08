function maximumDeletions(s) {
    const n = s.length;
    const dp = Array(n).fill(0);
    const count = Array(26).fill(0);

    for (let i = 0; i < n; i++) {
        let max = 0;
        for (let j = 0; j < 26; j++) {
            if (s[i] !== String.fromCharCode('a'.charCodeAt(0) + j)) {
                max = Math.max(max, count[j]);
            }
        }
        dp[i] = max + 1;
        count[s[i].charCodeAt(0) - 'a'.charCodeAt(0)] = Math.max(count[s[i].charCodeAt(0) - 'a'.charCodeAt(0)], dp[i]);
    }

    return Math.max(...dp);
}