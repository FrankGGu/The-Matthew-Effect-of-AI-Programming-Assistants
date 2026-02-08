var NestedIterator = function (nestedList) {
    this.stack = [];
    this.current = null;

    if (nestedList.length > 0) {
        this.stack.push(nestedList);
        this.current = nestedList;
    }
};

NestedIterator.prototype.hasNext = function () {
    while (this.stack.length > 0 && !this.current) {
        const list = this.stack[this.stack.length - 1];
        this.stack.pop();
        for (let i = list.length - 1; i >= 0; i--) {
            this.stack.push(list[i]);
        }
    }
    return this.stack.length > 0;
};

NestedIterator.prototype.next = function () {
    const value = this.current;
    this.current = null;
    this.hasNext();
    return value;
};