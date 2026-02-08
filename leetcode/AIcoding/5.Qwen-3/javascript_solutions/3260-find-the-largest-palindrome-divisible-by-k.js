function largestPalindrome(n, k) {
    const max = Math.pow(10, n) - 1;
    const min = Math.pow(10, n - 1);

    for (let i = max; i >= min; i--) {
        let s = i.toString();
        let palindrome = s + s.split('').reverse().join('');
        let num = parseInt(palindrome, 10);
        if (num % k === 0) return num;

        if (n > 1) {
            palindrome = s + s.split('').reverse().slice(1).join('');
            num = parseInt(palindrome, 10);
            if (num % k === 0) return num;
        }
    }

    return 0;
}