function earliestFullBloom(plantTime, growTime) {
    const n = plantTime.length;
    const pairs = Array.from({ length: n }, (_, i) => [plantTime[i], growTime[i]]);
    pairs.sort((a, b) => b[1] - a[1]);

    let maxDay = 0;
    let currentDay = 0;

    for (let i = 0; i < n; i++) {
        currentDay += pairs[i][0];
        maxDay = Math.max(maxDay, currentDay + pairs[i][1]);
    }

    return maxDay;
}