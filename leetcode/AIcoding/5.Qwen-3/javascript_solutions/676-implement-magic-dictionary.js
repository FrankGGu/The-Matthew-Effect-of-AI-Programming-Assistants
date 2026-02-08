function MagicDictionary() {
    this.words = [];
}

MagicDictionary.prototype.buildDict = function(dictionary) {
    this.words = dictionary;
};

MagicDictionary.prototype.search = function(word) {
    for (let w of this.words) {
        if (w.length !== word.length) continue;
        let diff = 0;
        for (let i = 0; i < word.length; i++) {
            if (w[i] !== word[i]) diff++;
            if (diff > 1) break;
        }
        if (diff === 1) return true;
    }
    return false;
};