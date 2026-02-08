function repeatedSubstringPattern(s) {
    return (s + s).indexOf(s, 1) !== s.length;
}