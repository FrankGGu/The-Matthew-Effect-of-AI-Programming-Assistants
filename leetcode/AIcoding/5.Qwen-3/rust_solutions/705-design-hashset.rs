struct MyHashSet {
    buckets: Vec<Vec<i32>>,
}

impl MyHashSet {
    fn new() -> Self {
        MyHashSet {
            buckets: vec![Vec::new(); 1000],
        }
    }

    fn add(&mut self, key: i32) {
        let index = key as usize % self.buckets.len();
        for &k in &self.buckets[index] {
            if k == key {
                return;
            }
        }
        self.buckets[index].push(key);
    }

    fn remove(&mut self, key: i32) {
        let index = key as usize % self.buckets.len();
        let mut i = 0;
        while i < self.buckets[index].len() {
            if self.buckets[index][i] == key {
                self.buckets[index].remove(i);
                return;
            }
            i += 1;
        }
    }

    fn contains(&self, key: i32) -> bool {
        let index = key as usize % self.buckets.len();
        for &k in &self.buckets[index] {
            if k == key {
                return true;
            }
        }
        false
    }
}