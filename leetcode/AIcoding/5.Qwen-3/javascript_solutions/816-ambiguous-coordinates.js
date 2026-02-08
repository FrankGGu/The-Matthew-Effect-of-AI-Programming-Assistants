function ambiguousCoordinates(s) {
    const result = [];
    s = s.slice(1, -1);
    for (let i = 1; i < s.length; i++) {
        const x = s.slice(0, i);
        const y = s.slice(i);
        const xOptions = generateOptions(x);
        const yOptions = generateOptions(y);
        for (const a of xOptions) {
            for (const b of yOptions) {
                result.push(`(${a}, ${b})`);
            }
        }
    }
    return result;
}

function generateOptions(str) {
    const options = [];
    if (str.length === 1) {
        options.push(str);
        return options;
    }
    if (str[0] !== '0') {
        options.push(str);
    }
    for (let i = 1; i < str.length; i++) {
        if (str[0] === '0') break;
        options.push(str.slice(0, i) + '.' + str.slice(i));
    }
    return options;
}