function flatten(head) {
    if (!head) return null;

    let current = head;

    while (current) {
        if (current.child) {
            const nextNode = current.next;
            const child = current.child;

            current.next = child;
            child.prev = current;

            let tail = child;
            while (tail.next) {
                tail = tail.next;
            }

            tail.next = nextNode;
            if (nextNode) {
                nextNode.prev = tail;
            }

            current.child = null;
        }

        current = current.next;
    }

    return head;
}