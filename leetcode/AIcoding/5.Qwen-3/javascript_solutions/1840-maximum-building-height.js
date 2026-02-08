function maxBuilding(n, restrictions) {
    const arr = new Array(n).fill(0);
    for (let i = 0; i < restrictions.length; i++) {
        arr[restrictions[i][0] - 1] = restrictions[i][1];
    }

    for (let i = 1; i < n; i++) {
        arr[i] = Math.min(arr[i], arr[i - 1] + 1);
    }

    for (let i = n - 2; i >= 0; i--) {
        arr[i] = Math.min(arr[i], arr[i + 1] + 1);
    }

    let max = 0;
    for (let i = 0; i < n; i++) {
        max = Math.max(max, arr[i]);
    }

    return max;
}