function smallestPalindrome(s) {
    const count = new Array(26).fill(0);
    for (const c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let firstHalf = '';
    let middle = '';
    for (let i = 0; i < 26; i++) {
        if (count[i] % 2 === 1) {
            middle = String.fromCharCode(i + 'a'.charCodeAt(0));
        }
        firstHalf += String.fromCharCode(i + 'a'.charCodeAt(0)).repeat(Math.floor(count[i] / 2));
    }

    const secondHalf = firstHalf.split('').reverse().join('');
    return firstHalf + middle + secondHalf;
}