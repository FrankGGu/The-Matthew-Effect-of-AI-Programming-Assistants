function smallestPali(str) {
    const count = new Array(26).fill(0);
    for (const c of str) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let oddChar = '';
    for (let i = 0; i < 26; i++) {
        if (count[i] % 2 === 1) {
            if (oddChar === '') {
                oddChar = String.fromCharCode(i + 'a'.charCodeAt(0));
            } else {
                return "NO";
            }
        }
    }

    const half = [];
    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < Math.floor(count[i] / 2); j++) {
            half.push(String.fromCharCode(i + 'a'.charCodeAt(0)));
        }
    }

    let left = half.join('');
    let right = left.split('').reverse().join('');

    if (oddChar !== '') {
        left += oddChar;
    }

    return left + right;
}