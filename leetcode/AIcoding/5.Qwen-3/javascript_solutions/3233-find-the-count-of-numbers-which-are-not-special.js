function countNonSpecialNumbers(low, high) {
    const isSpecial = (num) => {
        const s = num.toString();
        for (let i = 0; i < s.length; i++) {
            if (s[i] !== s[0]) return false;
        }
        return true;
    };

    let count = 0;
    for (let i = low; i <= high; i++) {
        if (!isSpecial(i)) {
            count++;
        }
    }
    return count;
}