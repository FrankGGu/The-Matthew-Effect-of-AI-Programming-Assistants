function countTime(time) {
    let [hour, minute] = time.split(':');
    let h1 = hour[0], h2 = hour[1];
    let m1 = minute[0], m2 = minute[1];
    let count = 0;

    for (let h = 0; h <= 23; h++) {
        let hStr = h.toString().padStart(2, '0');
        if (h1 !== '?' && h1 !== hStr[0]) continue;
        if (h2 !== '?' && h2 !== hStr[1]) continue;

        for (let m = 0; m <= 59; m++) {
            let mStr = m.toString().padStart(2, '0');
            if (m1 !== '?' && m1 !== mStr[0]) continue;
            if (m2 !== '?' && m2 !== mStr[1]) continue;
            count++;
        }
    }

    return count;
}