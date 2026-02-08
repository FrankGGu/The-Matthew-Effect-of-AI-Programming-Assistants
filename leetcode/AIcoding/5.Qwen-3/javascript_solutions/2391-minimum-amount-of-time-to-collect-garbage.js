function garbageCollection(garbage, travel) {
    let time = 0;
    const types = ['G', 'P', 'M'];

    for (const type of types) {
        let last = -1;
        for (let i = 0; i < garbage.length; i++) {
            if (garbage[i].includes(type)) {
                last = i;
                time += garbage[i].split('').filter(c => c === type).length;
            }
        }
        if (last !== -1) {
            for (let i = 0; i < last; i++) {
                time += travel[i];
            }
        }
    }

    return time;
}