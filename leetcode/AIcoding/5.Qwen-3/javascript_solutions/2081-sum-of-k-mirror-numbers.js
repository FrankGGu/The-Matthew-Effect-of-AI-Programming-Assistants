function kMirror(k, n) {
    function isPalindrome(num) {
        const s = num.toString();
        return s === s.split('').reverse().join('');
    }

    function generateKMirror(k) {
        const queue = ['1'];
        while (true) {
            const current = queue.shift();
            const num = parseInt(current, k);
            if (isPalindrome(num)) {
                yield num;
            }
            queue.push(current + '0');
            queue.push(current + '1');
        }
    }

    const gen = generateKMirror(k);
    let result = 0;
    for (let i = 0; i < n; i++) {
        result = gen.next().value;
    }
    return result;
}