function findTheDifference(s, t) {
    let sum = 0;
    for (let i = 0; i < s.length; i++) {
        sum -= s.charCodeAt(i);
        sum += t.charCodeAt(i);
    }
    sum += t.charCodeAt(t.length - 1);
    return String.fromCharCode(sum);
}