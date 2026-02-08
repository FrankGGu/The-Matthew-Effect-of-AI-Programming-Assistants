function kthDistinct(arr, k) {
    const count = {};
    for (const str of arr) {
        count[str] = (count[str] || 0) + 1;
    }
    for (const str of arr) {
        if (count[str] === 1) {
            k--;
            if (k === 0) {
                return str;
            }
        }
    }
    return "";
}