function partition(s) {
    const result = [];

    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    function backtrack(start, current) {
        if (start === s.length) {
            result.push([...current]);
            return;
        }
        for (let i = start; i < s.length; i++) {
            if (isPalindrome(s.substring(start, i + 1))) {
                current.push(s.substring(start, i + 1));
                backtrack(i + 1, current);
                current.pop();
            }
        }
    }

    backtrack(0, []);
    return result;
}