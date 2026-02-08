function deleteNodes(head, nums) {
    const set = new Set(nums);
    const dummy = new ListNode(0);
    dummy.next = head;
    let current = dummy;
    while (current && current.next) {
        if (set.has(current.next.val)) {
            current.next = current.next.next;
        } else {
            current = current.next;
        }
    }
    return dummy.next;
}