function minString(n, cost) {
    const chars = Array.from({ length: n }, (_, i) => String.fromCharCode(97 + i));
    const result = [];
    const used = new Set();

    for (let i = 0; i < n; i++) {
        let minCost = Infinity;
        let selectedIndex = -1;

        for (let j = 0; j < n; j++) {
            if (!used.has(j)) {
                if (cost[j] < minCost) {
                    minCost = cost[j];
                    selectedIndex = j;
                }
            }
        }

        if (selectedIndex === -1) break;

        result.push(chars[selectedIndex]);
        used.add(selectedIndex);
    }

    return result.join('');
}