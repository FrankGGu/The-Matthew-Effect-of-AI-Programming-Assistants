function numPermutations(n, m, relations) {
    const graph = new Array(n).fill(0).map(() => []);
    const inDegree = new Array(n).fill(0);
    for (const [a, b] of relations) {
        graph[a].push(b);
        inDegree[b]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let count = 0;
    let result = 0;
    const visited = new Array(n).fill(false);

    function dfs() {
        if (count === n) {
            result++;
            return;
        }
        for (let i = 0; i < n; i++) {
            if (!visited[i] && inDegree[i] === 0) {
                visited[i] = true;
                count++;
                for (const neighbor of graph[i]) {
                    inDegree[neighbor]--;
                }
                dfs();
                count--;
                for (const neighbor of graph[i]) {
                    inDegree[neighbor]++;
                }
                visited[i] = false;
            }
        }
    }

    dfs();
    return result;
}