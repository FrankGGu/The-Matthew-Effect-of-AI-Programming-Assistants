function reverseKGroup(head, k) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;
    let curr = head;

    while (true) {
        let count = 0;
        let last = curr;
        while (count < k && last) {
            last = last.next;
            count++;
        }
        if (count < k) break;

        let next = curr.next;
        curr.next = null;
        let newHead = reverse(curr);
        prev.next = newHead;
        prev = curr;
        curr = next;
    }

    return dummy.next;
}

function reverse(head) {
    let prev = null;
    let curr = head;
    while (curr) {
        let next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}

function ListNode(val, next) {
    this.val = (val === undefined ? 0 : val);
    this.next = (next === undefined ? null : next);
}