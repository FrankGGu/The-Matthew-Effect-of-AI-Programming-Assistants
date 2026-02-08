function findClosestTemperature(humidity) {
    let closest = humidity[0];
    for (let i = 1; i < humidity.length; i++) {
        if (Math.abs(humidity[i] - 50) < Math.abs(closest - 50)) {
            closest = humidity[i];
        }
    }
    return closest;
}