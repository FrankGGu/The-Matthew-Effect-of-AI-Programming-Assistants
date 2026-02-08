function getMinSwaps(s, k) {
    let arr = s.split('');
    let n = arr.length;
    for (let i = 0; i < k; i++) {
        let j = n - 2;
        while (j >= 0 && arr[j] >= arr[j + 1]) j--;
        let l = n - 1;
        while (arr[l] <= arr[j]) l--;
        [arr[j], arr[l]] = [arr[l], arr[j]];
        let left = j + 1, right = n - 1;
        while (left < right) [arr[left], arr[right]] = [arr[right], arr[left]], left++, right--;
    }
    let res = 0;
    for (let i = 0; i < n; i++) {
        let minPos = i;
        for (let j = i + 1; j < n; j++) {
            if (arr[j] < arr[minPos]) minPos = j;
        }
        for (let j = minPos; j > i; j--) {
            [arr[j], arr[j - 1]] = [arr[j - 1], arr[j]];
            res++;
        }
    }
    return res;
}