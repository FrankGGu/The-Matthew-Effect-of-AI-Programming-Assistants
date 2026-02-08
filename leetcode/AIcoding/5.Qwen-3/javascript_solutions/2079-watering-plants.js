function wateringPlants(plants, capacity) {
    let steps = 0;
    let currentCapacity = capacity;

    for (let i = 0; i < plants.length; i++) {
        if (currentCapacity < plants[i]) {
            steps += 2 * i;
            currentCapacity = capacity;
        }
        steps++;
        currentCapacity -= plants[i];
    }

    return steps;
}