function longestSpecialPath(s) {
    const n = s.length;
    const dp = new Array(n).fill(0);
    const prev = new Array(n).fill(-1);
    let maxLen = 1;
    let endIndex = 0;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (Math.abs(s.charCodeAt(i) - s.charCodeAt(j)) === 1) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }

        if (dp[i] > maxLen) {
            maxLen = dp[i];
            endIndex = i;
        }
    }

    const path = [];
    let curr = endIndex;
    while (curr !== -1) {
        path.push(s[curr]);
        curr = prev[curr];
    }

    return path.reverse().join('');
}