function removeComments(source) {
    const result = [];
    let inBlock = false;
    for (const line of source) {
        if (inBlock) {
            const end = line.indexOf('*/');
            if (end !== -1) {
                inBlock = false;
                result[result.length - 1] += line.slice(end + 2);
            }
        } else {
            const start = line.indexOf('');
            if (start === -1 && end === -1) {
                result.push(line);
            } else if (start !== -1 && end === -1) {
                result.push(line.slice(0, start));
                inBlock = true;
            } else if (start === -1 && end !== -1) {
                result.push(line.slice(0, end));
            } else {
                if (start < end) {
                    result.push(line.slice(0, start));
                } else {
                    result.push(line.slice(0, end));
                }
            }
        }
    }
    return result;
}