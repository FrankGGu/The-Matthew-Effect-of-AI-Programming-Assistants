var deleteDuplicates = function(head) {
    var dummy = new ListNode(0);
    dummy.next = head;
    var prev = dummy;
    var curr = head;
    while (curr) {
        while (curr.next && curr.val === curr.next.val) {
            curr = curr.next;
        }
        if (prev.next !== curr) {
            prev.next = curr.next;
        } else {
            prev = prev.next;
        }
        curr = curr.next;
    }
    return dummy.next;
};