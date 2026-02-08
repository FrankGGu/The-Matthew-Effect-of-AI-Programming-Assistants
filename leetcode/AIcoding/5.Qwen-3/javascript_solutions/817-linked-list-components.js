var numComponents = function(head, G) {
    const set = new Set(G);
    let count = 0;
    let inComponent = false;

    while (head) {
        if (set.has(head.val)) {
            inComponent = true;
        } else {
            if (inComponent) {
                count++;
                inComponent = false;
            }
        }
        head = head.next;
    }

    if (inComponent) count++;

    return count;
};