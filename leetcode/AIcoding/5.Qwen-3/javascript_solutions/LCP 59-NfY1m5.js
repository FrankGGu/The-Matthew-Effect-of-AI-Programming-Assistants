function bridgeCrossing(people) {
    people.sort((a, b) => a - b);
    const n = people.length;
    let totalTime = 0;

    while (n > 3) {
        if (people[0] + people[1] + 2 * people[n - 2] < people[0] + 2 * people[1] + people[n - 1]) {
            totalTime += people[0] + people[1] + people[n - 2];
            people.pop();
            people.pop();
            people.shift();
        } else {
            totalTime += people[0] + people[1] + people[n - 1];
            people.pop();
            people.shift();
            people.shift();
        }
    }

    if (n === 3) {
        totalTime += people[0] + people[1] + people[2];
    } else if (n === 2) {
        totalTime += people[1];
    } else if (n === 1) {
        totalTime += people[0];
    }

    return totalTime;
}