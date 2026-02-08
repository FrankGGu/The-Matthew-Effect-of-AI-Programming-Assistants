var PeekingIterator = function(iterator) {
    this.iterator = iterator;
    this.cache = null;
};

PeekingIterator.prototype.hasNext = function() {
    return this.cache !== null || this.iterator.hasNext();
};

PeekingIterator.prototype.next = function() {
    if (this.cache === null) {
        return this.iterator.next();
    } else {
        var value = this.cache;
        this.cache = null;
        return value;
    }
};

PeekingIterator.prototype.peek = function() {
    if (this.cache === null) {
        this.cache = this.iterator.next();
    }
    return this.cache;
};