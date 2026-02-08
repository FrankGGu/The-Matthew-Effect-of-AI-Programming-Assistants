impl Solution {

use std::collections::HashMap;

struct Solution {
    map: HashMap<i32, i32>,
    size: i32,
}

impl Solution {
    fn new(n: i32, blacklist: Vec<i32>) -> Self {
        let mut map = HashMap::new();
        let mut last = n - 1;
        for &b in &blacklist {
            if b < last {
                map.insert(b, last);
                last -= 1;
            }
        }
        Solution { map, size: n }
    }

    fn pick(&self) -> i32 {
        use rand::Rng;
        let mut rng = rand::thread_rng();
        let mut x = rng.gen_range(0..self.size);
        while self.map.contains_key(&x) {
            x = *self.map.get(&x).unwrap();
        }
        x
    }
}
}