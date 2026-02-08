function canVisitAllRooms(rooms) {
    const visited = new Set();
    const stack = [0];

    while (stack.length > 0) {
        const room = stack.pop();
        if (visited.has(room)) continue;
        visited.add(room);
        for (const key of rooms[room]) {
            if (!visited.has(key)) {
                stack.push(key);
            }
        }
    }

    return visited.size === rooms.length;
}