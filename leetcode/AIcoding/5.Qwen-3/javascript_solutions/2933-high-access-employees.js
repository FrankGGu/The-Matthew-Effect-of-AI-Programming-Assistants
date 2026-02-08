function highAccessEmployees(logs) {
    const accessMap = {};

    for (const [name, time] of logs) {
        if (!accessMap[name]) {
            accessMap[name] = [];
        }
        accessMap[name].push(parseInt(time));
    }

    const result = [];

    for (const name in accessMap) {
        const times = accessMap[name].sort((a, b) => a - b);
        for (let i = 0; i <= times.length - 3; i++) {
            if (times[i + 2] - times[i] < 100) {
                result.push(name);
                break;
            }
        }
    }

    return result;
}