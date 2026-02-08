function minMutation(startGene, endGene, bank) {
    const bankSet = new Set(bank);
    const queue = [startGene];
    const visited = new Set([startGene]);
    const chars = ['A', 'C', 'G', 'T'];
    let steps = 0;

    while (queue.length > 0) {
        const levelSize = queue.length;
        for (let i = 0; i < levelSize; i++) {
            const current = queue.shift();
            if (current === endGene) return steps;
            for (const c of chars) {
                for (let j = 0; j < 8; j++) {
                    const mutation = current.substring(0, j) + c + current.substring(j + 1);
                    if (bankSet.has(mutation) && !visited.has(mutation)) {
                        visited.add(mutation);
                        queue.push(mutation);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}