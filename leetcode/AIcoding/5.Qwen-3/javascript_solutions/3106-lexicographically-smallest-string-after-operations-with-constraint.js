function findLexSmallestString(s, a, b) {
    const visited = new Set();
    let minStr = s;

    function rotate(s, b) {
        const len = s.length;
        const shift = b % len;
        return s.slice(len - shift) + s.slice(0, len - shift);
    }

    function increment(s, a) {
        const arr = s.split('');
        for (let i = arr.length - 1; i >= 0; i--) {
            const digit = parseInt(arr[i]);
            const newDigit = (digit + a) % 10;
            arr[i] = newDigit.toString();
            if (newDigit !== digit) break;
        }
        return arr.join('');
    }

    function dfs(current) {
        if (visited.has(current)) return;
        visited.add(current);
        if (current < minStr) minStr = current;

        const rotated = rotate(current, b);
        dfs(rotated);

        const incremented = increment(current, a);
        dfs(incremented);
    }

    dfs(s);
    return minStr;
}