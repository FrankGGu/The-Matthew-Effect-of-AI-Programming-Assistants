function letterCasePermutation(s) {
    const result = [];
    function backtrack(index, path) {
        if (index === s.length) {
            result.push(path.join(''));
            return;
        }
        if (isNaN(s[index])) {
            backtrack(index + 1, path.concat(s[index].toLowerCase()));
            backtrack(index + 1, path.concat(s[index].toUpperCase()));
        } else {
            backtrack(index + 1, path.concat(s[index]));
        }
    }
    backtrack(0, []);
    return result;
}