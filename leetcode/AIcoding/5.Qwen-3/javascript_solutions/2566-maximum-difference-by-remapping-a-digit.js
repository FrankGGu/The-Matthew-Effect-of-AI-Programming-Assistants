function maxDiff(num) {
    const s = num.toString();
    let minNum = num;
    let maxNum = num;

    for (let i = 0; i < s.length; i++) {
        if (s[i] !== '9') {
            maxNum = parseInt(s.replace(new RegExp(s[i], 'g'), '9'));
            break;
        }
    }

    for (let i = 0; i < s.length; i++) {
        if (s[i] !== '0') {
            minNum = parseInt(s.replace(new RegExp(s[i], 'g'), '0'));
            break;
        }
    }

    return maxNum - minNum;
}