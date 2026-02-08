function maximumNumber(s, a) {
    let sArr = s.split('');
    let max = s;
    for (let i = 0; i < s.length; i++) {
        if (sArr[i] === '9') continue;
        let temp = sArr.slice();
        for (let j = i; j < s.length; j++) {
            if (temp[j] === '9') break;
            temp[j] = a[0];
            let num = temp.join('');
            if (num > max) {
                max = num;
            }
        }
    }
    return max;
}