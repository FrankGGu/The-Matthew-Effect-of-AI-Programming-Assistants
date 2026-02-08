function numberOfLines(widths, s) {
    let lines = 1;
    let width = 0;
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        const index = char.charCodeAt(0) - 'a'.charCodeAt(0);
        width += widths[index];
        if (width > 100) {
            lines++;
            width = widths[index];
        }
    }
    return [lines, width];
}