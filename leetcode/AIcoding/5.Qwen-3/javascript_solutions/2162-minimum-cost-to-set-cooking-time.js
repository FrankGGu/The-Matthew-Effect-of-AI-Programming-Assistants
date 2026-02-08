function minTimeToCook(targetTime, batchSize) {
    let time = 0;
    let count = 0;
    while (count < batchSize) {
        time++;
        if (time % targetTime === 0) {
            count++;
        }
    }
    return time;
}