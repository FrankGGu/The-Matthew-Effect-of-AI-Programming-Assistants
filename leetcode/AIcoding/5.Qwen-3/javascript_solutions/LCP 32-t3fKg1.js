function countTasks(tasks) {
    const map = new Map();
    for (const task of tasks) {
        map.set(task, (map.get(task) || 0) + 1);
    }
    let result = 0;
    for (const [key, value] of map.entries()) {
        if (value >= 2) {
            result += Math.floor(value / 2);
        }
    }
    return result;
}