function maxNumberOfAlloys(batteries, k) {
    let left = 0;
    let right = Math.max(...batteries);

    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        let total = 0;

        for (const battery of batteries) {
            total += Math.floor(battery / mid);
            if (total >= k) break;
        }

        if (total >= k) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}