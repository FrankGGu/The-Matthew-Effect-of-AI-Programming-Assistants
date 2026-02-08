function doubleLinkedList(head) {
    let carry = 0;
    let current = head;

    while (current) {
        let val = current.val * 2 + carry;
        current.val = val % 10;
        carry = Math.floor(val / 10);
        current = current.next;
    }

    if (carry > 0) {
        head = new ListNode(carry, head);
    }

    return head;
}