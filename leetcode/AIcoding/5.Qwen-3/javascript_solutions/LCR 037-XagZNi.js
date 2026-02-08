function asteroidCollision(asteroids) {
    const stack = [];

    for (const asteroid of asteroids) {
        let collide = true;
        while (stack.length > 0 && stack[stack.length - 1] > 0 && asteroid < 0) {
            if (stack[stack.length - 1] < -asteroid) {
                stack.pop();
            } else if (stack[stack.length - 1] === -asteroid) {
                stack.pop();
                collide = false;
                break;
            } else {
                collide = false;
                break;
            }
        }
        if (collide) {
            stack.push(asteroid);
        }
    }

    return stack;
}