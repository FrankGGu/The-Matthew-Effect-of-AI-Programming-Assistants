function findLongestUncommonSubsequence(strs) {
    strs.sort((a, b) => b.length - a.length || a.localeCompare(b));
    for (let i = 0; i < strs.length; i++) {
        let isUnique = true;
        for (let j = 0; j < strs.length; j++) {
            if (i !== j && isSubsequence(strs[i], strs[j])) {
                isUnique = false;
                break;
            }
        }
        if (isUnique) return strs[i].length;
    }
    return -1;
}

function isSubsequence(a, b) {
    let i = 0;
    for (let j = 0; i < a.length && j < b.length; j++) {
        if (a[i] === b[j]) i++;
    }
    return i === a.length;
}