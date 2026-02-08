var MyHashSet = function() {
    this.set = [];
};

MyHashSet.prototype.add = function(key) {
    if (!this.contains(key)) {
        this.set.push(key);
    }
};

MyHashSet.prototype.remove = function(key) {
    for (var i = 0; i < this.set.length; i++) {
        if (this.set[i] === key) {
            this.set.splice(i, 1);
            return;
        }
    }
};

MyHashSet.prototype.contains = function(key) {
    for (var i = 0; i < this.set.length; i++) {
        if (this.set[i] === key) {
            return true;
        }
    }
    return false;
};