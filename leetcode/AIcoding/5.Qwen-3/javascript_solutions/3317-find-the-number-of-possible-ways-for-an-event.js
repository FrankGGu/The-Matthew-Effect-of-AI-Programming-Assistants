function numberOfWays(arr, k) {
    const count = {};
    let result = 0;

    for (let i = 0; i < arr.length; i++) {
        const complement = k - arr[i];
        if (count[complement]) {
            result += count[complement];
        }
        count[arr[i]] = (count[arr[i]] || 0) + 1;
    }

    return result;
}