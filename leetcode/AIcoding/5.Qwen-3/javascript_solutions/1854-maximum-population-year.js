function maximumPopulation(logs) {
    const diff = Array(2051).fill(0);
    for (const [birth, death] of logs) {
        diff[birth]++;
        diff[death]--;
    }
    let max = 0;
    let current = 0;
    let year = 0;
    for (let i = 1900; i <= 2050; i++) {
        current += diff[i];
        if (current > max) {
            max = current;
            year = i;
        }
    }
    return year;
}