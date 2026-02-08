function maxRemovableCharacters(s, p, removable) {
    const n = s.length;
    const m = p.length;
    const k = removable.length;

    const isSubsequence = (s, p, removed) => {
        let i = 0, j = 0;
        while (i < s.length && j < p.length) {
            if (!removed[i] && s[i] === p[j]) {
                j++;
            }
            i++;
        }
        return j === p.length;
    };

    let left = 0, right = k;
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const removed = new Array(n).fill(false);
        for (let i = 0; i < mid; i++) {
            removed[removable[i]] = true;
        }
        if (isSubsequence(s, p, removed)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}