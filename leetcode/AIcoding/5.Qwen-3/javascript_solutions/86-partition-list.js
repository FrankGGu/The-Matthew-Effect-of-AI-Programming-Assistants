function partition(head, x) {
    let lessHead = new ListNode(0);
    let greaterHead = new ListNode(0);
    let lessTail = lessHead;
    let greaterTail = greaterHead;

    while (head) {
        if (head.val < x) {
            lessTail.next = head;
            lessTail = head;
        } else {
            greaterTail.next = head;
            greaterTail = head;
        }
        head = head.next;
    }

    lessTail.next = greaterHead.next;
    greaterTail.next = null;

    return lessHead.next;
}