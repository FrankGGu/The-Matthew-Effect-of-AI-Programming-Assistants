function maximumTotalImportance(n, roads) {
    const importance = new Array(n).fill(0);

    for (const [a, b] of roads) {
        importance[a]++;
        importance[b]++;
    }

    importance.sort((a, b) => b - a);

    let total = 0;
    for (let i = 0; i < n; i++) {
        total += importance[i] * (n - i);
    }

    return total;
}