function longestSubstring(s, k) {
    function helper(s, k) {
        if (s.length < k) return 0;
        const freq = {};
        for (const c of s) {
            freq[c] = (freq[c] || 0) + 1;
        }
        for (let i = 0; i < s.length; i++) {
            if (freq[s[i]] < k) {
                return Math.max(helper(s.substring(0, i), k), helper(s.substring(i + 1), k));
            }
        }
        return s.length;
    }
    return helper(s, k);
}