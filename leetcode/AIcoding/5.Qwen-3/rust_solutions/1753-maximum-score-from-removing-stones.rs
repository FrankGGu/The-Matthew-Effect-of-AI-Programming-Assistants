struct Solution {}

impl Solution {
    pub fn max_score(a: i32, b: i32, c: i32) -> i32 {
        let mut heap = std::collections::BinaryHeap::new();
        heap.push(a);
        heap.push(b);
        heap.push(c);

        let mut score = 0;

        while let (Some(x), Some(y)) = (heap.pop(), heap.pop()) {
            let z = heap.pop().unwrap_or(0);
            let new_x = x - 1;
            let new_y = y - 1;
            let new_z = z - 1;

            score += 1;

            if new_x > 0 {
                heap.push(new_x);
            }
            if new_y > 0 {
                heap.push(new_y);
            }
            if new_z > 0 {
                heap.push(new_z);
            }
        }

        score
    }
}