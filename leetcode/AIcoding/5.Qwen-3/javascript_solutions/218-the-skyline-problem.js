function getSkyline(prices) {
    const n = prices.length;
    if (n === 0) return [];

    const events = [];
    for (let i = 0; i < n; i++) {
        events.push([prices[i][0], -prices[i][1]]);
        events.push([prices[i][1], prices[i][1]]);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] - b[1];
    });

    const result = [];
    const prevHeight = 0;
    const currHeight = 0;
    const heap = new Heap();

    for (const event of events) {
        const pos = event[0];
        const height = event[1];

        if (height < 0) {
            heap.push(-height);
        } else {
            heap.remove(height);
        }

        const currentHeight = heap.size() > 0 ? heap.top() : 0;

        if (currentHeight !== prevHeight) {
            result.push([pos, currentHeight]);
            prevHeight = currentHeight;
        }
    }

    return result;
}

class Heap {
    constructor() {
        this.heap = [];
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    remove(value) {
        const index = this.heap.indexOf(value);
        if (index === -1) return;
        this.heap[index] = this.heap[this.heap.length - 1];
        this.heap.pop();
        this.bubbleDown(index);
    }

    top() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] <= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let swapIndex = null;
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;

            if (leftChildIndex < length && this.heap[leftChildIndex] < element) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.heap[rightChildIndex] < (swapIndex === null ? Infinity : this.heap[swapIndex])) {
                swapIndex = rightChildIndex;
            }

            if (swapIndex === null) break;
            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}