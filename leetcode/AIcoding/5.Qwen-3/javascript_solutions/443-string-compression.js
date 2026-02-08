function compress(chars) {
    let index = 0;
    let i = 0;
    while (i < chars.length) {
        const char = chars[i];
        let count = 0;
        while (i < chars.length && chars[i] === char) {
            i++;
            count++;
        }
        chars[index++] = char;
        if (count > 1) {
            const digits = count.toString().split('');
            for (const digit of digits) {
                chars[index++] = digit;
            }
        }
    }
    return index;
}