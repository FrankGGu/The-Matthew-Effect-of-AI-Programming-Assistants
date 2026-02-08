function missingRolls(rolls, mean, n) {
    const m = rolls.length;
    const total = (m + n) * mean;
    let sum = 0;
    for (let i = 0; i < m; i++) {
        sum += rolls[i];
    }
    const remaining = total - sum;
    if (remaining < n || remaining < 1) return [];
    const result = [];
    const base = Math.floor(remaining / n);
    const remainder = remaining % n;
    for (let i = 0; i < n; i++) {
        result.push(base + (i < remainder ? 1 : 0));
    }
    return result;
}