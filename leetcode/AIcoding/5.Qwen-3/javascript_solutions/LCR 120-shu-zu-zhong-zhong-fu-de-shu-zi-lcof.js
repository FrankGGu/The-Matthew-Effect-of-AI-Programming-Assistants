function findDuplicate(files) {
    const map = new Map();
    for (const [name, content] of files) {
        if (!map.has(content)) {
            map.set(content, []);
        }
        map.get(content).push(name);
    }
    const result = [];
    for (const [content, names] of map) {
        if (names.length > 1) {
            result.push(names);
        }
    }
    return result;
}