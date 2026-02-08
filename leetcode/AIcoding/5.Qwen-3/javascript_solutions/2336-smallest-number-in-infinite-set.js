class SmallestInfiniteSet {
    constructor() {
        this.current = 1;
        this.removed = new Set();
    }

    popSmallest() {
        while (this.removed.has(this.current)) {
            this.current++;
        }
        this.removed.add(this.current);
        return this.current++;
    }

    addBack(val) {
        if (val < this.current && !this.removed.has(val)) {
            this.removed.delete(val);
        }
    }
}