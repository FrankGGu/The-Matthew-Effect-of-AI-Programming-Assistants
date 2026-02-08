function minimumTimeToBrewPotions(time) {
    time.sort((a, b) => a - b);
    let total = 0;
    for (let i = 0; i < time.length; i++) {
        total += time[i] * (i + 1);
    }
    return total;
}