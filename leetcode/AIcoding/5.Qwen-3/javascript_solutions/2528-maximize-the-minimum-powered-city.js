function maxDistance(cities, k) {
    cities.sort((a, b) => a - b);

    function canPlace(dist) {
        let count = 1;
        let last = cities[0];

        for (let i = 1; i < cities.length; i++) {
            if (cities[i] - last >= dist) {
                count++;
                last = cities[i];
            }
        }

        return count >= k;
    }

    let left = 0;
    let right = cities[cities.length - 1] - cities[0];
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canPlace(mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}