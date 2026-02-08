function leastInterval(tasks, n) {
    const map = {};
    for (const task of tasks) {
        map[task] = (map[task] || 0) + 1;
    }

    const maxFreq = Math.max(...Object.values(map));
    let count = 0;
    for (const freq of Object.values(map)) {
        if (freq === maxFreq) {
            count++;
        }
    }

    return Math.max((maxFreq - 1) * (n + 1) + count, tasks.length);
}