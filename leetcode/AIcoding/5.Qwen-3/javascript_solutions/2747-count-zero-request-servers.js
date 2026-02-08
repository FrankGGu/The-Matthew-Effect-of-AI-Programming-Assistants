function countZeroRequests(servers, requests) {
    const count = new Array(servers.length).fill(0);
    const queue = [];
    let time = 0;

    for (const [start, end] of requests) {
        while (queue.length > 0 && queue[0][0] <= time) {
            const [_, server] = queue.shift();
            count[server]++;
        }

        let found = false;
        for (let i = 0; i < servers.length; i++) {
            if (count[i] === 0) {
                count[i]++;
                queue.push([end, i]);
                found = true;
                break;
            }
        }

        if (!found) {
            queue.push([end, -1]);
        }

        time++;
    }

    return count.filter(c => c === 0).length;
}