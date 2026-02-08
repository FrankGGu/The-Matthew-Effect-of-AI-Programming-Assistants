var Solution = function(m, n) {
    this.m = m;
    this.n = n;
    this.total = m * n;
    this.flipped = new Set();
};

Solution.prototype.flip = function() {
    while (true) {
        let r = Math.floor(Math.random() * this.m);
        let c = Math.floor(Math.random() * this.n);
        let key = r * this.n + c;
        if (!this.flipped.has(key)) {
            this.flipped.add(key);
            return [r, c];
        }
    }
};

Solution.prototype.reset = function() {
    this.flipped.clear();
};