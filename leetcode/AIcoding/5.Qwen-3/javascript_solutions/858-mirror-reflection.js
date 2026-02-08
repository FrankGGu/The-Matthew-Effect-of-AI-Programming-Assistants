var mirrorReflection = function(p, q) {
    let m = p, n = q;
    while (n) {
        let temp = n;
        n = m % n;
        m = temp;
    }
    let lcm = p * q / m;
    let a = lcm / p;
    let b = lcm / q;
    if (a % 2 === 0) return 2;
    if (b % 2 === 0) return 1;
    return 0;
};