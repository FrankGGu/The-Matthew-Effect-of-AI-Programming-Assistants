function longestMountain(A) {
    let max = 0;
    let i = 1;
    while (i < A.length - 1) {
        let up = 0, down = 0;
        while (i < A.length - 1 && A[i] > A[i - 1]) {
            i++;
            up++;
        }
        while (i < A.length - 1 && A[i] < A[i - 1]) {
            i++;
            down++;
        }
        if (up > 0 && down > 0) {
            max = Math.max(max, up + down + 1);
        } else {
            i++;
        }
    }
    return max;
}