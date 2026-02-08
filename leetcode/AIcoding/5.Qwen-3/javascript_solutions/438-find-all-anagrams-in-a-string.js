function findAnagrams(s, p) {
    const result = [];
    const count = new Array(26).fill(0);
    const lenS = s.length;
    const lenP = p.length;

    if (lenP > lenS) return result;

    for (let i = 0; i < lenP; i++) {
        count[p.charCodeAt(i) - 97]++;
    }

    let left = 0;
    for (let right = 0; right < lenS; right++) {
        count[s.charCodeAt(right) - 97]--;
        while (count[s.charCodeAt(right) - 97] < 0) {
            count[s.charCodeAt(left) - 97]++;
            left++;
        }
        if (right - left + 1 === lenP) {
            result.push(left);
        }
    }

    return result;
}