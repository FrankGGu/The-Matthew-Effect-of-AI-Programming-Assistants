function rearrangeCharacters(s, target) {
    const count = {};
    for (const c of s) {
        count[c] = (count[c] || 0) + 1;
    }

    const targetCount = {};
    for (const c of target) {
        targetCount[c] = (targetCount[c] || 0) + 1;
    }

    let min = Infinity;
    for (const c in targetCount) {
        if (!count[c]) return 0;
        min = Math.min(min, Math.floor(count[c] / targetCount[c]));
    }

    return min;
}