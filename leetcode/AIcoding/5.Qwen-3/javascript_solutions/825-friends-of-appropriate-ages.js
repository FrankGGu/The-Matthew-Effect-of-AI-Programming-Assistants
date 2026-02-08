function numFriendRequests(ages) {
    const count = new Array(121).fill(0);
    for (const age of ages) {
        count[age]++;
    }

    let total = 0;
    for (let ageA = 1; ageA <= 120; ageA++) {
        for (let ageB = 1; ageB <= 120; ageB++) {
            if (ageB > 0.5 * ageA + 10 && ageB <= ageA) {
                if (ageA === ageB) {
                    total += count[ageA] * (count[ageA] - 1);
                } else {
                    total += count[ageA] * count[ageB];
                }
            }
        }
    }
    return total;
}