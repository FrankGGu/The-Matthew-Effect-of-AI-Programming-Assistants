function expressiveWords(s, words) {
    function getGroups(str) {
        const groups = [];
        let i = 0;
        while (i < str.length) {
            const char = str[i];
            let count = 0;
            while (i < str.length && str[i] === char) {
                i++;
                count++;
            }
            groups.push([char, count]);
        }
        return groups;
    }

    const sGroups = getGroups(s);
    let result = 0;

    for (const word of words) {
        const wordGroups = getGroups(word);
        if (wordGroups.length !== sGroups.length) continue;
        let valid = true;
        for (let i = 0; i < sGroups.length; i++) {
            const [sChar, sCount] = sGroups[i];
            const [wChar, wCount] = wordGroups[i];
            if (sChar !== wChar || wCount > sCount || (sCount < 3 && wCount < sCount)) {
                valid = false;
                break;
            }
        }
        if (valid) result++;
    }

    return result;
}