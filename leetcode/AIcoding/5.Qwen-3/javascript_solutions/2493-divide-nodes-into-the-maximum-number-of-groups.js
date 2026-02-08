function isGoodGraph(graph) {
    const color = {};
    const queue = [];

    for (let i = 0; i < graph.length; i++) {
        if (!(i in color)) {
            color[i] = 0;
            queue.push(i);
            while (queue.length > 0) {
                const node = queue.shift();
                for (const neighbor of graph[node]) {
                    if (neighbor in color) {
                        if (color[neighbor] === color[node]) return false;
                    } else {
                        color[neighbor] = color[node] ^ 1;
                        queue.push(neighbor);
                    }
                }
            }
        }
    }
    return true;
}

function maxGroups(graph) {
    let result = 0;
    const visited = new Set();

    function dfs(node, depth) {
        let maxDepth = depth;
        for (const neighbor of graph[node]) {
            if (!visited.has(neighbor)) {
                visited.add(neighbor);
                maxDepth = Math.max(maxDepth, dfs(neighbor, depth + 1));
            }
        }
        return maxDepth;
    }

    for (let i = 0; i < graph.length; i++) {
        if (!visited.has(i)) {
            visited.add(i);
            const depth = dfs(i, 1);
            result += depth;
        }
    }

    return result;
}