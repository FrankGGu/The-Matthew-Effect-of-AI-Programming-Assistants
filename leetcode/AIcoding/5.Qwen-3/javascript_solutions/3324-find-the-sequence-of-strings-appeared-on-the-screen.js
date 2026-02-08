function stringSequence(target) {
    const result = [];
    const chars = 'abcdefghijklmnopqrstuvwxyz';

    function backtrack(current) {
        if (current.length > target.length) return;
        if (current === target) {
            result.push(current);
            return;
        }
        for (let i = 0; i < chars.length; i++) {
            const nextChar = chars[i];
            const nextStr = current + nextChar;
            if (nextStr.length > target.length) continue;
            if (nextStr > target) break;
            result.push(nextStr);
            backtrack(nextStr);
            if (result[result.length - 1] === target) return;
        }
    }

    backtrack('');
    return result;
}