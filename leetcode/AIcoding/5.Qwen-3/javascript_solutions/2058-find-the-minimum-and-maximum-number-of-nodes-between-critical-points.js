function nodesBetweenCriticalPoints(head) {
    let prev = head;
    let curr = head.next;
    let next = curr ? curr.next : null;
    let criticalIndices = [];
    let index = 1;

    while (next) {
        if ((curr.val > prev.val && curr.val > next.val) || (curr.val < prev.val && curr.val < next.val)) {
            criticalIndices.push(index);
        }
        prev = curr;
        curr = next;
        next = next.next;
        index++;
    }

    if (criticalIndices.length < 2) {
        return [-1, -1];
    }

    let minDist = Infinity;
    let maxDist = criticalIndices[criticalIndices.length - 1] - criticalIndices[0];

    for (let i = 1; i < criticalIndices.length; i++) {
        minDist = Math.min(minDist, criticalIndices[i] - criticalIndices[i - 1]);
    }

    return [minDist, maxDist];
}