struct FrontMiddleBackQueue {
    front: Vec<i32>,
    back: Vec<i32>,
}

impl FrontMiddleBackQueue {
    fn new() -> Self {
        FrontMiddleBackQueue { front: Vec::new(), back: Vec::new() }
    }

    fn push_front(&mut self, val: i32) {
        self.front.push(val);
    }

    fn push_middle(&mut self, val: i32) {
        if self.front.len() > self.back.len() {
            self.back.insert(0, self.front.pop().unwrap());
        }
        self.front.push(val);
    }

    fn push_back(&mut self, val: i32) {
        self.back.push(val);
    }

    fn pop_front(&mut self) -> i32 {
        if self.front.is_empty() {
            let val = self.back.remove(0);
            return val;
        } else if self.back.is_empty() {
            return self.front.pop().unwrap();
        } else {
            let val = self.front.pop().unwrap();
            self.back.insert(0, self.front.pop().unwrap());
            return val;
        }
    }

    fn pop_middle(&mut self) -> i32 {
        if self.front.len() == self.back.len() {
            let val = self.front.pop().unwrap();
            self.back.insert(0, self.front.pop().unwrap());
            return val;
        } else {
            let val = self.front.pop().unwrap();
            return val;
        }
    }

    fn pop_back(&mut self) -> i32 {
        if self.back.is_empty() {
            let val = self.front.pop().unwrap();
            self.back.insert(0, self.front.pop().unwrap());
            return val;
        } else {
            return self.back.pop().unwrap();
        }
    }
}