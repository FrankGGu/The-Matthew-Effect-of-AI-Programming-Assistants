function closestRoom(rooms, queries) {
    const n = rooms.length;
    const m = queries.length;
    const sortedRooms = rooms.slice().sort((a, b) => b[1] - a[1]);
    const indexedQueries = queries.map((q, i) => [q[0], q[1], i]);
    indexedQueries.sort((a, b) => b[1] - a[1]);

    const result = new Array(m);
    let roomIdx = 0;

    const availableRooms = [];

    for (const [queryId, radius, originalIndex] of indexedQueries) {
        while (roomIdx < n && sortedRooms[roomIdx][1] >= radius) {
            availableRooms.push(sortedRooms[roomIdx][0]);
            roomIdx++;
        }

        availableRooms.sort((a, b) => a - b);
        let closest = availableRooms[0];
        for (let i = 1; i < availableRooms.length; i++) {
            if (Math.abs(availableRooms[i] - queryId) < Math.abs(closest - queryId)) {
                closest = availableRooms[i];
            }
        }
        result[originalIndex] = closest;
    }

    return result;
}