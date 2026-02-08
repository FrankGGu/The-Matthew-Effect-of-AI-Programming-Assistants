function removeNodes(head) {
    let stack = [];
    let current = head;
    while (current) {
        while (stack.length > 0 && stack[stack.length - 1].val < current.val) {
            stack.pop();
        }
        stack.push(current);
        current = current.next;
    }
    let dummy = new ListNode(0);
    current = dummy;
    for (let node of stack) {
        current.next = node;
        current = current.next;
    }
    current.next = null;
    return dummy.next;
}