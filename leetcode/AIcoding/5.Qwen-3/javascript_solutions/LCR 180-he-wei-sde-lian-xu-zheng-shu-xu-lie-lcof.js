function findDuplicateFiles(input) {
    const map = {};
    const result = [];

    for (const line of input) {
        const parts = line.split(' ');
        const hash = parts[0];
        const path = parts.slice(1).join(' ');

        if (!map[hash]) {
            map[hash] = [];
        }

        map[hash].push(path);
    }

    for (const key in map) {
        if (map[key].length > 1) {
            result.push(map[key]);
        }
    }

    return result;
}