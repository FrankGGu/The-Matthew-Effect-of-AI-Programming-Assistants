function shortestSubarray(nums, k) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    let result = Infinity;
    const deque = [];

    for (let i = 0; i <= n; i++) {
        while (deque.length > 0 && prefix[i] - prefix[deque[0]] >= k) {
            result = Math.min(result, i - deque.shift());
        }

        while (deque.length > 0 && prefix[i] <= prefix[deque[deque.length - 1]]) {
            deque.pop();
        }

        deque.push(i);
    }

    return result === Infinity ? -1 : result;
}