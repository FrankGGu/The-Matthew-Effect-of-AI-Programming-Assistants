function minCostToMakeStringUnique(s) {
    const used = new Set();
    let cost = 0;
    let current = s.length - 1;

    for (let i = s.length - 1; i >= 0; i--) {
        if (used.has(s[i])) {
            while (used.has(String.fromCharCode(current))) {
                current--;
            }
            if (current < 97) {
                return -1;
            }
            used.add(String.fromCharCode(current));
            cost += current - s[i].charCodeAt(0);
            current--;
        } else {
            used.add(s[i]);
        }
    }

    return cost;
}