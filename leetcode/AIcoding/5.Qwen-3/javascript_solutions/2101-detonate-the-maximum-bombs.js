function maximumDetonatedBombs(bombs) {
    const n = bombs.length;
    const graph = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < n; i++) {
        const [x1, y1, r1] = bombs[i];
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            const [x2, y2] = bombs[j];
            const distance = Math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2);
            if (distance <= r1) {
                graph[i].push(j);
            }
        }
    }

    let max = 0;

    for (let i = 0; i < n; i++) {
        const visited = new Set();
        const queue = [i];
        visited.add(i);

        while (queue.length > 0) {
            const node = queue.shift();
            for (const neighbor of graph[node]) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push(neighbor);
                }
            }
        }

        max = Math.max(max, visited.size);
    }

    return max;
}