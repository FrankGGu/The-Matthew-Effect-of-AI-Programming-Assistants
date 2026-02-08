function assignTasks(servers, tasks) {
    const availableServers = new PriorityQueue((a, b) => a[0] !== b[0] ? a[0] - b[0] : a[1] - b[1]);
    const busyServers = new PriorityQueue((a, b) => a[0] - b[0]);

    for (let i = 0; i < servers.length; i++) {
        availableServers.enqueue([servers[i], i]);
    }

    const result = new Array(tasks.length);
    let time = 0;

    for (let i = 0; i < tasks.length; i++) {
        time = Math.max(time, i);

        while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
            const [serverTime, serverWeight, serverIndex] = busyServers.dequeue();
            availableServers.enqueue([serverWeight, serverIndex]);
        }

        if (availableServers.isEmpty()) {
            time = busyServers.peek()[0];
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
                const [serverTime, serverWeight, serverIndex] = busyServers.dequeue();
                availableServers.enqueue([serverWeight, serverIndex]);
            }
        }

        const [serverWeight, serverIndex] = availableServers.dequeue();
        result[i] = serverIndex;
        busyServers.enqueue([time + tasks[i], serverWeight, serverIndex]);
    }

    return result;
}

class PriorityQueue {
    constructor(comparator) {
        this.heap = [];
        this.comparator = comparator;
    }

    enqueue(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    dequeue() {
        if (this.heap.length === 1) return this.heap.pop();
        const value = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown(0);
        return value;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        const parent = Math.floor((index - 1) / 2);
        if (parent >= 0 && this.comparator(this.heap[index], this.heap[parent]) < 0) {
            [this.heap[index], this.heap[parent]] = [this.heap[parent], this.heap[index]];
            this.bubbleUp(parent);
        }
    }

    bubbleDown(index) {
        const left = 2 * index + 1;
        const right = 2 * index + 2;
        let smallest = index;

        if (left < this.heap.length && this.comparator(this.heap[left], this.heap[smallest]) < 0) {
            smallest = left;
        }

        if (right < this.heap.length && this.comparator(this.heap[right], this.heap[smallest]) < 0) {
            smallest = right;
        }

        if (smallest !== index) {
            [this.heap[index], this.heap[smallest]] = [this.heap[smallest], this.heap[index]];
            this.bubbleDown(smallest);
        }
    }
}