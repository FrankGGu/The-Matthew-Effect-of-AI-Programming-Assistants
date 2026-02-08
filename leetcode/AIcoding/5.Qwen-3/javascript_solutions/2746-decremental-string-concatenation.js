function minimizeConcatenatedConnection(words) {
    let result = words[0];
    for (let i = 1; i < words.length; i++) {
        let min = Infinity;
        let best = "";
        for (let j = 0; j < words[i].length; j++) {
            let candidate = result + words[i].substring(j);
            if (candidate.length < min) {
                min = candidate.length;
                best = candidate;
            }
        }
        for (let j = 0; j < result.length; j++) {
            let candidate = words[i] + result.substring(j);
            if (candidate.length < min) {
                min = candidate.length;
                best = candidate;
            }
        }
        result = best;
    }
    return result;
}