var FrequencyStack = function() {
    this.freq = {};
    this.groups = {};
    this.maxFreq = 0;
};

FrequencyStack.prototype.push = function(val) {
    let count = this.freq[val] || 0;
    this.freq[val] = count + 1;
    if (!this.groups[count + 1]) {
        this.groups[count + 1] = [];
    }
    this.groups[count + 1].push(val);
    this.maxFreq = Math.max(this.maxFreq, count + 1);
};

FrequencyStack.prototype.pop = function() {
    let val = this.groups[this.maxFreq].pop();
    this.freq[val]--;
    if (this.groups[this.maxFreq].length === 0) {
        delete this.groups[this.maxFreq];
        this.maxFreq--;
    }
    return val;
};