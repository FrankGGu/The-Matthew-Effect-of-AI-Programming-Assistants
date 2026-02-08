struct SmallestInfiniteSet {
    current: i32,
    removed: std::collections::HashSet<i32>,
}

impl SmallestInfiniteSet {
    fn new() -> Self {
        SmallestInfiniteSet {
            current: 1,
            removed: std::collections::HashSet::new(),
        }
    }

    fn pop_smallest(&mut self) -> i32 {
        while self.removed.contains(&self.current) {
            self.current += 1;
        }
        let val = self.current;
        self.removed.insert(val);
        self.current += 1;
        val
    }

    fn add_back(&mut self, num: i32) {
        if num < self.current {
            self.removed.remove(&num);
        }
    }
}