function longestCommonPrefix(arr) {
    if (arr.length === 0) return 0;
    let prefix = arr[0];
    for (let i = 1; i < arr.length; i++) {
        while (arr[i].indexOf(prefix) !== 0) {
            prefix = prefix.slice(0, -1);
            if (prefix === "") return 0;
        }
    }
    return prefix.length;
}