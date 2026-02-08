function combinationSum2(candidates, target) {
    const result = [];
    candidates.sort((a, b) => a - b);

    function backtrack(start, path, remaining) {
        if (remaining === 0) {
            result.push([...path]);
            return;
        }

        for (let i = start; i < candidates.length; i++) {
            if (i > start && candidates[i] === candidates[i - 1]) continue;
            if (candidates[i] > remaining) break;
            path.push(candidates[i]);
            backtrack(i + 1, path, remaining - candidates[i]);
            path.pop();
        }
    }

    backtrack(0, [], target);
    return result;
}