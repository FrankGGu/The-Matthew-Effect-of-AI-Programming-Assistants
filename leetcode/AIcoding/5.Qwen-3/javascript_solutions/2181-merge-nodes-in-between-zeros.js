var mergeNodes = function(head) {
    let dummy = new ListNode(0);
    let current = dummy;
    let sum = 0;
    head = head.next;
    while (head) {
        if (head.val === 0) {
            current.next = new ListNode(sum);
            current = current.next;
            sum = 0;
        } else {
            sum += head.val;
        }
        head = head.next;
    }
    return dummy.next;
};