function combinationSum3(k, n) {
    const result = [];

    function backtrack(start, path, sum) {
        if (path.length === k) {
            if (sum === n) {
                result.push([...path]);
            }
            return;
        }

        for (let i = start; i <= 9; i++) {
            if (sum + i > n) break;
            path.push(i);
            backtrack(i + 1, path, sum + i);
            path.pop();
        }
    }

    backtrack(1, [], 0);
    return result;
}