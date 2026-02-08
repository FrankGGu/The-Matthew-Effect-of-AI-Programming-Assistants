function minRefuelStops(target, startFuel, stations) {
    const maxHeap = [];
    let fuel = startFuel;
    let stops = 0;
    let i = 0;

    while (fuel < target) {
        while (i < stations.length && stations[i][0] <= fuel) {
            maxHeap.push(stations[i][1]);
            i++;
        }

        if (maxHeap.length === 0) return -1;

        fuel += -Math.max(...maxHeap);
        maxHeap.splice(maxHeap.indexOf(-Math.max(...maxHeap)), 1);
        stops++;
    }

    return stops;
}