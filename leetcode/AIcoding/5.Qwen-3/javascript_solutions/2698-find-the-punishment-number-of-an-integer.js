function punishmentNumber(n) {
    function isPossible(s, target) {
        if (s === "") return target === 0;
        for (let i = 1; i <= s.length; i++) {
            let num = parseInt(s.substring(0, i));
            if (num > target) break;
            if (isPossible(s.substring(i), target - num)) {
                return true;
            }
        }
        return false;
    }

    let result = 0;
    for (let i = 1; i <= n; i++) {
        let s = i.toString();
        if (isPossible(s, i)) {
            result += i * i;
        }
    }
    return result;
}