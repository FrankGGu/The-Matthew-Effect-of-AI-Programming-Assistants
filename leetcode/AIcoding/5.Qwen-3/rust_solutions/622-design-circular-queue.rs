struct MyCircularQueue {
    data: Vec<i32>,
    capacity: usize,
    front: usize,
    rear: usize,
    size: usize,
}

impl MyCircularQueue {
    fn new(k: i32) -> Self {
        MyCircularQueue {
            data: vec![0; k as usize],
            capacity: k as usize,
            front: 0,
            rear: 0,
            size: 0,
        }
    }

    fn en_queue(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }
        self.data[self.rear] = value;
        self.rear = (self.rear + 1) % self.capacity;
        self.size += 1;
        true
    }

    fn de_queue(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }
        self.front = (self.front + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn front(&self) -> i32 {
        if self.is_empty() {
            -1
        } else {
            self.data[self.front]
        }
    }

    fn rear(&self) -> i32 {
        if self.is_empty() {
            -1
        } else {
            self.data[self.rear.wrapping_sub(1)]
        }
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}