function spiralMatrix(m, n, head) {
    const result = [];
    for (let i = 0; i < m; i++) {
        result.push(new Array(n).fill(0));
    }

    let top = 0, bottom = m - 1, left = 0, right = n - 1;

    while (head !== null) {
        for (let i = left; i <= right && head !== null; i++) {
            result[top][i] = head.val;
            head = head.next;
        }
        top++;

        for (let i = top; i <= bottom && head !== null; i++) {
            result[i][right] = head.val;
            head = head.next;
        }
        right--;

        for (let i = right; i >= left && head !== null; i--) {
            result[bottom][i] = head.val;
            head = head.next;
        }
        bottom--;

        for (let i = bottom; i >= top && head !== null; i--) {
            result[i][left] = head.val;
            head = head.next;
        }
        left++;
    }

    return result;
}