function numSubarraysWithOddSum(arr) {
    let count = 0;
    let prefixSum = 0;
    let oddCount = 0;
    let evenCount = 1;

    for (let i = 0; i < arr.length; i++) {
        prefixSum += arr[i];
        if (prefixSum % 2 === 1) {
            count += evenCount;
            oddCount++;
        } else {
            count += oddCount;
            evenCount++;
        }
    }

    return count;
}