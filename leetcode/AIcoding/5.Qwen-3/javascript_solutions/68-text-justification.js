function fullJustify(words, maxWidth) {
    const result = [];
    let line = [];
    let lineLength = 0;

    for (const word of words) {
        if (lineLength + word.length + (line.length > 0 ? 1 : 0) > maxWidth) {
            let spaces = maxWidth - lineLength;
            let gaps = line.length - 1;
            let spaceCount = 1;

            if (gaps === 0) {
                result.push(line[0].padEnd(maxWidth));
            } else {
                while (spaces > 0) {
                    for (let i = 0; i < gaps && spaces > 0; i++) {
                        line[i] += ' ';
                        spaces--;
                    }
                }
                result.push(line.join(''));
            }
            line = [word];
            lineLength = word.length;
        } else {
            line.push(word);
            lineLength += word.length + (line.length > 1 ? 1 : 0);
        }
    }

    result.push(line.join(' ').padEnd(maxWidth));

    return result;
}