function largestPalindromic(num) {
    const count = new Array(10).fill(0);
    for (const c of num) {
        count[parseInt(c)]++;
    }

    let left = '';
    let right = '';

    for (let i = 9; i >= 0; i--) {
        if (count[i] > 0) {
            if (i === 0 && left === '') {
                continue;
            }
            const half = Math.floor(count[i] / 2);
            if (half > 0) {
                left += String(i).repeat(half);
                right += String(i).repeat(half);
                count[i] -= half * 2;
            }
        }
    }

    let middle = '';
    for (let i = 9; i >= 0; i--) {
        if (count[i] > 0) {
            middle = String(i);
            break;
        }
    }

    return left + middle + right;
}