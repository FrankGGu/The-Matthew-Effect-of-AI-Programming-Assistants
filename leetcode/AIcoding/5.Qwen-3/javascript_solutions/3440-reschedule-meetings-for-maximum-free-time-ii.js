function maxFreeTime(schedule) {
    const events = [];
    for (const meeting of schedule) {
        events.push([meeting[0], 'start']);
        events.push([meeting[1], 'end']);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] === 'start' ? -1 : 1;
    });

    let freeStart = null;
    let maxFree = 0;
    let active = 0;

    for (const [time, type] of events) {
        if (type === 'start') {
            if (freeStart !== null) {
                maxFree = Math.max(maxFree, time - freeStart);
                freeStart = null;
            }
            active++;
        } else {
            active--;
            if (active === 0) {
                freeStart = time;
            }
        }
    }

    return maxFree;
}