var isMonotonic = function(A) {
    let increasing = true;
    let decreasing = true;
    for (let i = 1; i < A.length; i++) {
        if (A[i] > A[i-1]) decreasing = false;
        if (A[i] < A[i-1]) increasing = false;
        if (!increasing && !decreasing) return false;
    }
    return true;
};