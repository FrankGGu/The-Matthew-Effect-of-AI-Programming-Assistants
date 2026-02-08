function minTime(arr, t) {
    let left = 0;
    let right = Math.max(...arr) * t;

    const canComplete = (time) => {
        let total = 0;
        for (let i = 0; i < arr.length; i++) {
            total += Math.floor(time / arr[i]);
            if (total >= t) return true;
        }
        return false;
    };

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canComplete(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}