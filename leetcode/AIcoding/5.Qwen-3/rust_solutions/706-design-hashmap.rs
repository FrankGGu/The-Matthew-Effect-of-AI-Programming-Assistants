struct MyHashMap {
    buckets: Vec<Vec<(i32, i32)>>,
}

impl MyHashMap {
    fn new() -> Self {
        MyHashMap {
            buckets: vec![Vec::new(); 1000],
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        let index = (key as usize) % self.buckets.len();
        for pair in &mut self.buckets[index] {
            if pair.0 == key {
                pair.1 = value;
                return;
            }
        }
        self.buckets[index].push((key, value));
    }

    fn get(&self, key: i32) -> i32 {
        let index = (key as usize) % self.buckets.len();
        for pair in &self.buckets[index] {
            if pair.0 == key {
                return pair.1;
            }
        }
        -1
    }

    fn remove(&mut self, key: i32) {
        let index = (key as usize) % self.buckets.len();
        self.buckets[index].retain(|pair| pair.0 != key);
    }
}