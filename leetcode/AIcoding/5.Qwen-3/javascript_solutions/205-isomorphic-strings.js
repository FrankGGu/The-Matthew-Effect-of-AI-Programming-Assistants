function isIsomorphic(s, t) {
    if (s.length !== t.length) return false;
    const mapS = {};
    const mapT = {};
    for (let i = 0; i < s.length; i++) {
        const charS = s[i];
        const charT = t[i];
        if (mapS[charS] && mapS[charS] !== charT) return false;
        if (mapT[charT] && mapT[charT] !== charS) return false;
        mapS[charS] = charT;
        mapT[charT] = charS;
    }
    return true;
}