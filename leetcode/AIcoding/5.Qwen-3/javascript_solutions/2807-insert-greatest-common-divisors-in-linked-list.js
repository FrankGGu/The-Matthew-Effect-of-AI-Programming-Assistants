function insertGreatestCommonDivisors(head) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let current = head;
    while (current && current.next) {
        let g = gcd(current.val, current.next.val);
        let newNode = new ListNode(g);
        newNode.next = current.next;
        current.next = newNode;
        current = newNode.next;
    }
    return head;
}