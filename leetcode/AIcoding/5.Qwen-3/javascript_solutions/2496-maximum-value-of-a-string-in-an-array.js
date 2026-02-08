function maximumValue(strs) {
    let max = 0;
    for (let s of strs) {
        let value = 0;
        for (let c of s) {
            value += c.charCodeAt(0) - 'a'.charCodeAt(0) + 1;
        }
        if (value > max) {
            max = value;
        }
    }
    return max;
}