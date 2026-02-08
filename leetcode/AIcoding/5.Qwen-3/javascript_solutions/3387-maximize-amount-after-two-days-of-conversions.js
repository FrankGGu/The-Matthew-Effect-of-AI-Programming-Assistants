function maxAmount(initial, conversions) {
    const map = new Map();
    for (const [from, to, rate] of conversions) {
        if (!map.has(from)) {
            map.set(from, []);
        }
        map.get(from).push([to, rate]);
    }

    const visited = new Set();
    let maxAmount = initial;

    function dfs(current, amount) {
        if (visited.has(current)) return;
        visited.add(current);
        maxAmount = Math.max(maxAmount, amount);
        if (map.has(current)) {
            for (const [next, rate] of map.get(current)) {
                dfs(next, amount * rate);
            }
        }
        visited.delete(current);
    }

    for (const [from, to, rate] of conversions) {
        dfs(from, initial * rate);
    }

    return maxAmount;
}