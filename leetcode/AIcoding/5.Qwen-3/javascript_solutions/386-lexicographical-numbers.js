function lexicalOrder(n) {
    const result = [];

    function dfs(start) {
        for (let i = start; i <= n; i++) {
            result.push(i);
            dfs(i * 10);
        }
    }

    dfs(1);
    return result;
}