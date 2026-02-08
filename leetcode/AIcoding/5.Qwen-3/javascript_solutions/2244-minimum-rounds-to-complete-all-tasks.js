function minimumRounds(tasks) {
    const count = {};
    for (const task of tasks) {
        count[task] = (count[task] || 0) + 1;
    }

    let rounds = 0;
    for (const key in count) {
        const c = count[key];
        if (c === 1) return -1;
        rounds += Math.ceil(c / 3);
    }
    return rounds;
}