struct LUPrefix {
    prefix: usize,
    marked: Vec<bool>,
}

impl LUPrefix {
    fn new(n: i32) -> Self {
        LUPrefix {
            prefix: 0,
            marked: vec![false; n as usize],
        }
    }

    fn upload(&mut self, video: i32) {
        let idx = video as usize;
        self.marked[idx] = true;
        while self.prefix < self.marked.len() && self.marked[self.prefix] {
            self.prefix += 1;
        }
    }

    fn longest(&self) -> i32 {
        self.prefix as i32
    }
}