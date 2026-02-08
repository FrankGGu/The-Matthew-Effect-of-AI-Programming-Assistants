function shortestPalindrome(s) {
    let rev = s.split('').reverse().join('');
    let combined = s + '#' + rev;
    let lps = new Array(combined.length).fill(0);
    for (let i = 1; i < combined.length; i++) {
        let j = lps[i - 1];
        while (j > 0 && combined[i] !== combined[j]) {
            j = lps[j - 1];
        }
        if (combined[i] === combined[j]) {
            j++;
        }
        lps[i] = j;
    }
    return rev.substring(0, s.length - lps[combined.length - 1]) + s;
}