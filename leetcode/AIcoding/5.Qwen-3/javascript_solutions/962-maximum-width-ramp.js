function maxWidthRamp(A) {
    const n = A.length;
    const stack = [];

    for (let i = 0; i < n; i++) {
        if (stack.length === 0 || A[i] < A[stack[stack.length - 1]]) {
            stack.push(i);
        }
    }

    let maxWidth = 0;

    for (let j = n - 1; j >= 0; j--) {
        while (stack.length > 0 && A[j] >= A[stack[stack.length - 1]]) {
            const i = stack.pop();
            maxWidth = Math.max(maxWidth, j - i);
        }
    }

    return maxWidth;
}