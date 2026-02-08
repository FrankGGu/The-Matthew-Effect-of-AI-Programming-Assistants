function findLatestTime(events, time) {
    let result = -1;
    for (let i = 0; i < events.length; i++) {
        if (events[i][0] <= time && events[i][1] >= time) {
            result = Math.max(result, events[i][1]);
        }
    }
    return result;
}