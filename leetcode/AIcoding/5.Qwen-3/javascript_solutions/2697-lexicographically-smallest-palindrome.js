function makeSmallestPalindrome(s) {
    let arr = s.split('');
    let left = 0;
    let right = arr.length - 1;
    while (left < right) {
        if (arr[left] !== arr[right]) {
            arr[left] = arr[right];
        }
        left++;
        right--;
    }
    return arr.join('');
}