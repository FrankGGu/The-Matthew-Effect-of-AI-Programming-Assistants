function meetPeople(n, people) {
    let closest = 0;
    let minDist = Infinity;

    for (let i = 0; i < n; i++) {
        if (people[i] === 1) {
            let dist = Math.abs(i - closest);
            if (dist < minDist) {
                minDist = dist;
                closest = i;
            }
        }
    }

    return closest;
}