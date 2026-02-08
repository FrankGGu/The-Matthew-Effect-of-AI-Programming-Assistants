function kSum(nums, k) {
    let sum = 0;
    for (let num of nums) {
        sum += Math.abs(num);
    }

    let minHeap = new MinHeap();
    minHeap.push([Math.abs(nums[0]), 0]);

    let res = sum;
    while (k > 1 && !minHeap.isEmpty()) {
        let [current, index] = minHeap.pop();
        res = current;
        if (index + 1 < nums.length) {
            minHeap.push([current + Math.abs(nums[index + 1]), index + 1]);
            minHeap.push([current - Math.abs(nums[index + 1]), index + 1]);
        }
        k--;
    }

    return res;
}

class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const top = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return top;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] <= this.heap[index][0]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swapIndex = null;

            if (leftChildIndex < length && this.heap[leftChildIndex][0] < element[0]) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.heap[rightChildIndex][0] < (swapIndex === null ? element[0] : this.heap[swapIndex][0])) {
                swapIndex = rightChildIndex;
            }

            if (swapIndex === null) break;
            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}