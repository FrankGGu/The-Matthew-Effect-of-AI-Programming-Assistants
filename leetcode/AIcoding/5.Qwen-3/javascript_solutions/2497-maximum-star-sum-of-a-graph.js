function maximumStarSum(nums, edges) {
    const n = nums.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Set();

    function dfs(node) {
        if (visited.has(node)) return 0;
        visited.add(node);
        let sum = nums[node];
        for (const neighbor of graph[node]) {
            if (!visited.has(neighbor)) {
                sum += dfs(neighbor);
            }
        }
        return sum;
    }

    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        if (!visited.has(i)) {
            const currentSum = dfs(i);
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
}