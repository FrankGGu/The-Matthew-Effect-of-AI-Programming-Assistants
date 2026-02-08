function maxProduct(s) {
    const n = s.length;
    const palindromes = [];

    function generatePalindromes(start, current) {
        if (start > n) return;
        if (current.length > 0) {
            const reversed = current.split('').reverse().join('');
            const full = current + reversed;
            if (full.length >= 2) {
                palindromes.push(current);
            }
        }
        for (let i = start; i < n; i++) {
            generatePalindromes(i + 1, current + s[i]);
        }
    }

    generatePalindromes(0, '');

    let maxProduct = 0;

    for (let i = 0; i < palindromes.length; i++) {
        for (let j = i + 1; j < palindromes.length; j++) {
            const set1 = new Set(palindromes[i]);
            const set2 = new Set(palindromes[j]);
            let hasCommon = false;
            for (const c of set1) {
                if (set2.has(c)) {
                    hasCommon = true;
                    break;
                }
            }
            if (!hasCommon) {
                maxProduct = Math.max(maxProduct, palindromes[i].length * palindromes[j].length);
            }
        }
    }

    return maxProduct;
}