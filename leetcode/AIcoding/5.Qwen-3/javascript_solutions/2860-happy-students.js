function countStudents(students, sandwiches) {
    const queue = [...students];
    let i = 0;

    while (i < sandwiches.length) {
        if (queue[0] === sandwiches[i]) {
            queue.shift();
            i++;
        } else {
            let found = false;
            for (let j = 1; j < queue.length; j++) {
                if (queue[j] === sandwiches[i]) {
                    found = true;
                    break;
                }
            }
            if (!found) break;
            queue.push(queue.shift());
        }
    }

    return queue.length;
}