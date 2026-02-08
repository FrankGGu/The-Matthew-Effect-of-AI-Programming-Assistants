function encodePath(path) {
    const result = [];
    let i = 0;
    while (i < path.length) {
        if (path[i] === '/') {
            result.push('/');
            i++;
        } else {
            let j = i;
            while (j < path.length && path[j] !== '/') {
                j++;
            }
            const segment = path.slice(i, j);
            result.push(segment);
            i = j;
        }
    }
    return result.join('/');
}