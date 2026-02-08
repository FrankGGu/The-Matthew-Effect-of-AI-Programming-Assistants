function sumSubarrayMins(A) {
    const MOD = 10**9 + 7;
    const N = A.length;
    const left = new Array(N).fill(0);
    const right = new Array(N).fill(0);

    const stack = [];

    for (let i = 0; i < N; i++) {
        let count = 1;
        while (stack.length > 0 && A[stack[stack.length - 1]] > A[i]) {
            count += left[stack.pop()];
        }
        left[i] = count;
        stack.push(i);
    }

    stack.length = 0;

    for (let i = N - 1; i >= 0; i--) {
        let count = 1;
        while (stack.length > 0 && A[stack[stack.length - 1]] >= A[i]) {
            count += right[stack.pop()];
        }
        right[i] = count;
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < N; i++) {
        result = (result + A[i] * left[i] * right[i]) % MOD;
    }

    return result;
}