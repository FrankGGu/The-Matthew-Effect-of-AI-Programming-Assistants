function checkIfAllAAreBeforeB(s) {
    let aSeen = false;
    for (let char of s) {
        if (char === 'a') {
            aSeen = true;
        } else if (char === 'b') {
            if (aSeen) {
                continue;
            } else {
                return false;
            }
        }
    }
    return true;
}