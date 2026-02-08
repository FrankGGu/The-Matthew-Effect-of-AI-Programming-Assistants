function longestPath(parent, s) {
    const n = s.length;
    const children = Array.from({ length: n }, () => []);

    for (let i = 1; i < n; i++) {
        children[parent[i]].push(i);
    }

    let result = 0;

    function dfs(node) {
        let max1 = 0, max2 = 0;
        for (const child of children[node]) {
            const val = dfs(child);
            if (s[child] !== s[node]) {
                if (val > max1) {
                    max2 = max1;
                    max1 = val;
                } else if (val > max2) {
                    max2 = val;
                }
            }
        }
        result = Math.max(result, max1 + max2 + 1);
        return max1 + 1;
    }

    dfs(0);
    return result;
}