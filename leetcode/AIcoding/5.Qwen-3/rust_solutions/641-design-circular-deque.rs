struct CircularDeque {
    capacity: usize,
    data: Vec<i32>,
    front: usize,
    rear: usize,
    size: usize,
}

impl CircularDeque {
    fn new(k: i32) -> Self {
        CircularDeque {
            capacity: k as usize,
            data: vec![0; k as usize],
            front: 0,
            rear: 0,
            size: 0,
        }
    }

    fn insert_front(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }
        self.front = (self.front + self.capacity - 1) % self.capacity;
        self.data[self.front] = value;
        self.size += 1;
        true
    }

    fn insert_rear(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }
        self.data[self.rear] = value;
        self.rear = (self.rear + 1) % self.capacity;
        self.size += 1;
        true
    }

    fn delete_front(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }
        self.front = (self.front + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn delete_rear(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }
        self.rear = (self.rear + self.capacity - 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn get_front(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }
        self.data[self.front]
    }

    fn get_rear(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }
        self.data[(self.rear + self.capacity - 1) % self.capacity]
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}

fn main() {
    // This is just a placeholder to satisfy the LeetCode environment
}