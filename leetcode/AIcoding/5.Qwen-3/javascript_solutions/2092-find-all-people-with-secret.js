function findAllPeople(n, meetings, firstPerson) {
    const graph = new Map();

    for (let i = 0; i < n; i++) {
        graph.set(i, []);
    }

    for (const [x, y, t] of meetings) {
        graph.get(x).push([y, t]);
        graph.get(y).push([x, t]);
    }

    const visited = new Set();
    visited.add(firstPerson);

    const queue = [];
    queue.push([firstPerson, 0]);

    while (queue.length > 0) {
        const [person, time] = queue.shift();
        for (const [neighbor, t] of graph.get(person)) {
            if (t >= time && !visited.has(neighbor)) {
                visited.add(neighbor);
                queue.push([neighbor, t]);
            }
        }
    }

    return Array.from(visited);
}