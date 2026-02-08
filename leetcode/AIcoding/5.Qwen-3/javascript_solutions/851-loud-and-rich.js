function loudAndRich(roads, names) {
    const graph = {};
    const inDegree = {};
    const nameToIndex = {};

    for (let i = 0; i < names.length; i++) {
        nameToIndex[names[i]] = i;
        graph[i] = [];
        inDegree[i] = 0;
    }

    for (const [richer, poorer] of roads) {
        const u = nameToIndex[richer];
        const v = nameToIndex[poorer];
        graph[u].push(v);
        inDegree[v]++;
    }

    const result = [];
    const queue = [];

    for (let i = 0; i < names.length; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const current = queue.shift();
        result.push(current);

        for (const neighbor of graph[current]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    const indexToName = {};
    for (let i = 0; i < names.length; i++) {
        indexToName[i] = names[i];
    }

    return result.map(index => indexToName[index]);
}