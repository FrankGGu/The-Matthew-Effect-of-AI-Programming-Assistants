function mergeSort(arr, temp, left, right) {
    let count = 0;
    if (left < right) {
        const mid = Math.floor((left + right) / 2);
        count += mergeSort(arr, temp, left, mid);
        count += mergeSort(arr, temp, mid + 1, right);
        count += merge(arr, temp, left, mid, right);
    }
    return count;
}

function merge(arr, temp, left, mid, right) {
    let i = left;
    let j = mid + 1;
    let k = left;
    let count = 0;

    while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            count += (mid - i + 1);
        }
    }

    while (i <= mid) {
        temp[k++] = arr[i++];
    }

    while (j <= right) {
        temp[k++] = arr[j++];
    }

    for (let x = left; x <= right; x++) {
        arr[x] = temp[x];
    }

    return count;
}

function countInversions(arr) {
    const n = arr.length;
    const temp = new Array(n).fill(0);
    return mergeSort(arr, temp, 0, n - 1);
}