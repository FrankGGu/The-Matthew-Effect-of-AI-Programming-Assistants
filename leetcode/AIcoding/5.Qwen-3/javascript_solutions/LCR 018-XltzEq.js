function isPalindrome(s) {
    const regex = /[^a-zA-Z0-9]/g;
    s = s.replace(regex, '').toLowerCase();
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}