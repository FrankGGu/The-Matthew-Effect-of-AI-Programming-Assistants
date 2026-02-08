function findBlackBlocks(n, queries) {
    const blackBlocks = new Map();
    const result = [];

    for (const [x, y] of queries) {
        const key = `${x},${y}`;
        if (blackBlocks.has(key)) {
            blackBlocks.set(key, blackBlocks.get(key) + 1);
        } else {
            blackBlocks.set(key, 1);
        }

        let count = 0;
        for (let i = Math.max(0, x - 1); i <= Math.min(n - 1, x + 1); i++) {
            for (let j = Math.max(0, y - 1); j <= Math.min(n - 1, y + 1); j++) {
                const blockKey = `${i},${j}`;
                if (blackBlocks.has(blockKey)) {
                    count += blackBlocks.get(blockKey);
                }
            }
        }

        result.push(count);
    }

    return result;
}