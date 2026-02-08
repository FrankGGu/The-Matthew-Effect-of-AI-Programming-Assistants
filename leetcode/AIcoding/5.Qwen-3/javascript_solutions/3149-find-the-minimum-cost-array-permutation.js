function minCostArrayPermutation(cost, labels, friends) {
    const n = cost.length;
    const pairs = Array.from({ length: n }, (_, i) => ({ cost: cost[i], label: labels[i], index: i }));

    pairs.sort((a, b) => a.cost - b.cost);

    const result = new Array(n);
    const labelCount = {};
    const friendSet = new Set(friends);

    let ptr = 0;
    let selected = 0;

    while (selected < n) {
        const current = pairs[ptr];
        if (friendSet.has(current.index)) {
            if (!labelCount[current.label] || labelCount[current.label] < 2) {
                result[selected++] = current.index;
                labelCount[current.label] = (labelCount[current.label] || 0) + 1;
            }
        } else {
            if (!labelCount[current.label] || labelCount[current.label] < 1) {
                result[selected++] = current.index;
                labelCount[current.label] = (labelCount[current.label] || 0) + 1;
            }
        }
        ptr++;
    }

    return result;
}