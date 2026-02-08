var carFleet = function(target, position, speed) {
    let stack = [];
    let pairs = position.map((pos, i) => [pos, speed[i]]);
    pairs.sort((a, b) => b[0] - a[0]);

    for (let [pos, spd] of pairs) {
        let time = (target - pos) / spd;
        if (stack.length === 0 || time > stack[stack.length - 1]) {
            stack.push(time);
        }
    }

    return stack.length;
};