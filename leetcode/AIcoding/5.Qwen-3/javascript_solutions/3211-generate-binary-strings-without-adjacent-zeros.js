function generateBinaryStrings(n) {
    const result = [];

    function backtrack(current) {
        if (current.length === n) {
            result.push(current);
            return;
        }

        if (current.length === 0 || current[current.length - 1] === '0') {
            backtrack(current + '1');
        } else {
            backtrack(current + '0');
            backtrack(current + '1');
        }
    }

    backtrack('');
    return result;
}