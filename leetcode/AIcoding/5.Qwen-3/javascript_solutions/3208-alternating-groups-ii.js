function numberOfAlternatingGroups(s) {
    const n = s.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        const prev = s[(i - 1 + n) % n];
        const curr = s[i];
        const next = s[(i + 1) % n];
        if (prev !== curr && curr !== next) {
            count++;
        }
    }
    return count;
}