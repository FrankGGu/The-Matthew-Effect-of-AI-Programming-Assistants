function exclusiveTime(n, logs) {
    const result = new Array(n).fill(0);
    const stack = [];
    let prevTime = 0;

    for (const log of logs) {
        const [id, type, time] = log.split(':');
        const idNum = parseInt(id);
        const timeNum = parseInt(time);

        if (type === 'start') {
            if (stack.length > 0) {
                result[stack[stack.length - 1]] += timeNum - prevTime;
            }
            stack.push(idNum);
            prevTime = timeNum;
        } else {
            if (stack.length > 0) {
                result[stack.pop()] += timeNum - prevTime + 1;
                prevTime = timeNum + 1;
            }
        }
    }

    return result;
}