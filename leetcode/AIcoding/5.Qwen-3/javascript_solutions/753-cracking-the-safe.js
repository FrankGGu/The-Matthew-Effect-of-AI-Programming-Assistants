function crackSafe(n, k) {
    if (n === 1 && k === 1) return "0";
    const visited = new Set();
    const result = [];

    function dfs(node) {
        for (let i = 0; i < k; i++) {
            const next = node + i.toString();
            if (!visited.has(next)) {
                visited.add(next);
                result.push(i.toString());
                dfs(next.slice(1));
                if (result.length === Math.pow(k, n) + n - 1) return;
                result.pop();
                visited.delete(next);
            }
        }
    }

    dfs("0".repeat(n - 1));
    return result.join("");
}