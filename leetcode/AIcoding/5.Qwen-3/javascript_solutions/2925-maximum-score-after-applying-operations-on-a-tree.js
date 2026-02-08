function maximumScore(nums, edges) {
    const n = nums.length;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < n - 1; i++) {
        const [u, v] = edges[i];
        graph[u].push(v);
        graph[v].push(u);
    }

    let res = 0;

    function dfs(node, parent) {
        const subtree = [nums[node]];
        for (const child of graph[node]) {
            if (child !== parent) {
                const sub = dfs(child, node);
                subtree.push(...sub);
            }
        }
        return subtree;
    }

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const a = dfs(i, -1);
            const b = dfs(j, -1);
            const set = new Set([...a, ...b]);
            if (set.size === a.length + b.length) {
                res = Math.max(res, nums[i] * nums[j]);
            }
        }
    }

    return res;
}