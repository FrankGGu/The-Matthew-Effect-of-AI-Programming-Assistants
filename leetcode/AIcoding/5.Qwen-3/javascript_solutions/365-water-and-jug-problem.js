function canMeasureWater(x, y, z) {
    if (z === 0) return true;
    if (x + y < z) return false;
    if (x === 0 || y === 0) return z % Math.max(x, y) === 0;
    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    return z % gcd(x, y) === 0;
}