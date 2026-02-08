function maxProduct(s) {
    const n = s.length;
    const pal = new Array(n).fill(0).map(() => new Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        pal[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            pal[i][i + 1] = true;
        }
    }

    for (let length = 3; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1;
            if (s[i] === s[j] && pal[i + 1][j - 1]) {
                pal[i][j] = true;
            }
        }
    }

    const list = [];
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            if (pal[i][j]) {
                list.push({ start: i, end: j, len: j - i + 1 });
            }
        }
    }

    let maxProd = 0;
    for (let i = 0; i < list.length; i++) {
        for (let j = i + 1; j < list.length; j++) {
            const a = list[i];
            const b = list[j];
            if (a.end < b.start || b.end < a.start) {
                maxProd = Math.max(maxProd, a.len * b.len);
            }
        }
    }

    return maxProd;
}