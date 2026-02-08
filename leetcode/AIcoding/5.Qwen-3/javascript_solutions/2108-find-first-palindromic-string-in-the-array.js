var firstPalindrome = function(words) {
    for (let word of words) {
        let left = 0;
        let right = word.length - 1;
        let isPalindrome = true;
        while (left < right) {
            if (word[left] !== word[right]) {
                isPalindrome = false;
                break;
            }
            left++;
            right--;
        }
        if (isPalindrome) return word;
    }
    return "";
};