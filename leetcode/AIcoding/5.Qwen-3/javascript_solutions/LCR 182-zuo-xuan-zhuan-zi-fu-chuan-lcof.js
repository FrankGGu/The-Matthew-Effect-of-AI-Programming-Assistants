function isDynamicPassword(target, key) {
    let i = 0;
    for (let j = 0; j < target.length; j++) {
        if (i < key.length && target[j] === key[i]) {
            i++;
        }
    }
    return i === key.length;
}