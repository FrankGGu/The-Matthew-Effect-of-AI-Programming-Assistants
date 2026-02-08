function findSubstring(s, power, modulo, k, hashValue) {
    const n = s.length;
    let currentHash = 0;
    let powerK = 1;

    for (let i = 0; i < k; i++) {
        currentHash = (currentHash * power + s.charCodeAt(i)) % modulo;
        powerK = (powerK * power) % modulo;
    }

    if (currentHash === hashValue) {
        return s.substring(0, k);
    }

    for (let i = k; i < n; i++) {
        currentHash = (currentHash - s.charCodeAt(i - k) * powerK) % modulo;
        currentHash = (currentHash * power + s.charCodeAt(i)) % modulo;
        if (currentHash === hashValue) {
            return s.substring(i - k + 1, i + 1);
        }
    }

    return "";
}