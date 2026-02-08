function superPalindromes() {
    const limit = 2 * 10 ** 8;
    const result = [];

    function isPalindrome(n) {
        const s = n.toString();
        return s === s.split('').reverse().join('');
    }

    for (let i = 1; i <= 100000; i++) {
        const s = i.toString();
        const p = parseInt(s + s.slice(0, s.length - 1).split('').reverse().join(''), 10);
        if (p > limit) break;
        if (isPalindrome(p)) {
            result.push(p);
        }
        const q = parseInt(s + s.slice(0, s.length).split('').reverse().join(''), 10);
        if (q > limit) break;
        if (isPalindrome(q)) {
            result.push(q);
        }
    }

    result.sort((a, b) => a - b);

    const finalResult = [];
    for (const num of result) {
        const sqrtNum = Math.sqrt(num);
        if (sqrtNum % 1 === 0 && isPalindrome(parseInt(sqrtNum))) {
            finalResult.push(num);
        }
    }

    return finalResult.length;
}