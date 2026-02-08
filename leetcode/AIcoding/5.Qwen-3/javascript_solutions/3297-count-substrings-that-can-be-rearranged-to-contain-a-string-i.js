function countPossibleSubstrings(s, k) {
    const n = s.length;
    const freq = new Array(26).fill(0);
    let left = 0;
    let result = 0;

    for (let right = 0; right < n; right++) {
        freq[s.charCodeAt(right) - 97]++;

        while (right - left + 1 > k) {
            freq[s.charCodeAt(left) - 97]--;
            left++;
        }

        if (right - left + 1 === k) {
            let valid = true;
            for (let i = 0; i < 26; i++) {
                if (freq[i] % 2 !== 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) result++;
        }
    }

    return result;
}