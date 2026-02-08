function findRadius(houses, heaters) {
    heaters.sort((a, b) => a - b);
    let maxRadius = 0;
    for (let house of houses) {
        let left = 0, right = heaters.length - 1;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (heaters[mid] < house) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        let radius = Math.abs(heaters[left] - house);
        if (left > 0) {
            radius = Math.min(radius, Math.abs(heaters[left - 1] - house));
        }
        maxRadius = Math.max(maxRadius, radius);
    }
    return maxRadius;
}