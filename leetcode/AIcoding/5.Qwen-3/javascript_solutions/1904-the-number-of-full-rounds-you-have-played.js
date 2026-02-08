function numberOfFullRounds(startTime, endTime) {
    function toMinutes(time) {
        const [h, m] = time.split(':').map(Number);
        return h * 60 + m;
    }

    const start = toMinutes(startTime);
    const end = toMinutes(endTime);

    if (start > end) {
        return 0;
    }

    const fullRounds = Math.floor((end - start) / 60);
    return fullRounds;
}