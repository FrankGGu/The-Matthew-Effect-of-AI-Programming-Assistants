var LUPrefix = function(n) {
    this.uploads = new Set();
    this.prefix = 0;
};

LUPrefix.prototype.upload = function(video) {
    this.uploads.add(video);
    while (this.uploads.has(this.prefix)) {
        this.prefix++;
    }
};

LUPrefix.prototype.longest = function() {
    return this.prefix;
};