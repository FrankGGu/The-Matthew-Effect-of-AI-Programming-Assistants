function inventoryManagement(weights) {
    let left = 0, right = weights.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (weights[mid] > weights[right]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return weights[left];
}