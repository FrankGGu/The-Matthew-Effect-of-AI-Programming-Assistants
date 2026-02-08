var MyLinkedList = function() {
    this.head = null;
    this.size = 0;
};

MyLinkedList.prototype.getNode = function(index) {
    let current = this.head;
    for (let i = 0; i < index; i++) {
        current = current.next;
    }
    return current;
};

MyLinkedList.prototype.get = function(index) {
    if (index < 0 || index >= this.size) {
        return -1;
    }
    const node = this.getNode(index);
    return node.val;
};

MyLinkedList.prototype.addAtHead = function(val) {
    this.addAtIndex(0, val);
};

MyLinkedList.prototype.addAtTail = function(val) {
    this.addAtIndex(this.size, val);
};

MyLinkedList.prototype.addAtIndex = function(index, val) {
    if (index > this.size) {
        return;
    }
    const newNode = { val: val, next: null };
    if (index === 0) {
        newNode.next = this.head;
        this.head = newNode;
    } else {
        const prevNode = this.getNode(index - 1);
        newNode.next = prevNode.next;
        prevNode.next = newNode;
    }
    this.size++;
};

MyLinkedList.prototype.deleteAtIndex = function(index) {
    if (index < 0 || index >= this.size) {
        return;
    }
    if (index === 0) {
        this.head = this.head.next;
    } else {
        const prevNode = this.getNode(index - 1);
        prevNode.next = prevNode.next.next;
    }
    this.size--;
};