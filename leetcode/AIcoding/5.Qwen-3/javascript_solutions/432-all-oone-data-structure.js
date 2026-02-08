var AllOne = function() {
    this.keys = new Map();
    this.bucketHead = new Bucket();
    this.bucketTail = new Bucket();
    this.bucketHead.next = this.bucketTail;
    this.bucketTail.prev = this.bucketHead;
};

var Bucket = function() {
    this.count = 0;
    this.keys = new Set();
    this.prev = null;
    this.next = null;
};

Bucket.prototype.isEmpty = function() {
    return this.keys.size === 0;
};

Bucket.prototype.remove = function() {
    this.prev.next = this.next;
    this.next.prev = this.prev;
};

AllOne.prototype.insert = function(key) {
    if (this.keys.has(key)) {
        this.incr(key);
        return;
    }
    let bucket = this.bucketHead.next;
    if (bucket.count === 1) {
        bucket.keys.add(key);
    } else {
        let newBucket = new Bucket();
        newBucket.count = 1;
        newBucket.keys.add(key);
        newBucket.prev = this.bucketHead;
        newBucket.next = this.bucketHead.next;
        this.bucketHead.next.prev = newBucket;
        this.bucketHead.next = newBucket;
    }
    this.keys.set(key, this.bucketHead.next);
};

AllOne.prototype.incr = function(key) {
    let bucket = this.keys.get(key);
    let nextBucket = bucket.next;
    if (nextBucket.count === bucket.count + 1) {
        nextBucket.keys.add(key);
    } else {
        let newBucket = new Bucket();
        newBucket.count = bucket.count + 1;
        newBucket.keys.add(key);
        newBucket.prev = bucket;
        newBucket.next = nextBucket;
        nextBucket.prev = newBucket;
        bucket.next = newBucket;
    }
    bucket.keys.delete(key);
    if (bucket.isEmpty()) {
        bucket.remove();
    }
    this.keys.set(key, nextBucket);
};

AllOne.prototype.decr = function(key) {
    let bucket = this.keys.get(key);
    if (bucket.count === 1) {
        bucket.keys.delete(key);
        if (bucket.isEmpty()) {
            bucket.remove();
        }
        this.keys.delete(key);
        return;
    }
    let prevBucket = bucket.prev;
    if (prevBucket.count === bucket.count - 1) {
        prevBucket.keys.add(key);
    } else {
        let newBucket = new Bucket();
        newBucket.count = bucket.count - 1;
        newBucket.keys.add(key);
        newBucket.prev = prevBucket;
        newBucket.next = bucket;
        prevBucket.next = newBucket;
        bucket.prev = newBucket;
    }
    bucket.keys.delete(key);
    if (bucket.isEmpty()) {
        bucket.remove();
    }
    this.keys.set(key, prevBucket);
};

AllOne.prototype.getMaxKey = function() {
    let bucket = this.bucketTail.prev;
    return bucket.keys.size > 0 ? [...bucket.keys][0] : "";
};

AllOne.prototype.getMinKey = function() {
    let bucket = this.bucketHead.next;
    return bucket.keys.size > 0 ? [...bucket.keys][0] : "";
};