function countArrangement(n) {
    let result = 0;
    const visited = new Array(n + 1).fill(false);

    function backtrack(k) {
        if (k > n) {
            result++;
            return;
        }
        for (let i = 1; i <= n; i++) {
            if (!visited[i] && (i % k === 0 || k % i === 0)) {
                visited[i] = true;
                backtrack(k + 1);
                visited[i] = false;
            }
        }
    }

    backtrack(1);
    return result;
}