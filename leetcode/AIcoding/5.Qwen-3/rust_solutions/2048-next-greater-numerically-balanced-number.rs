struct Solution;

impl Solution {
    pub fn next_beautiful(n: i32) -> i32 {
        fn is_balanced(mut num: i32) -> bool {
            let mut count = [0; 10];
            while num > 0 {
                let d = num % 10;
                count[d as usize] += 1;
                num /= 10;
            }
            for i in 1..=9 {
                if count[i] != 0 && count[i] != i {
                    return false;
                }
            }
            true
        }

        let mut current = n + 1;
        while current < 10_000_000 {
            if is_balanced(current) {
                return current;
            }
            current += 1;
        }
        -1
    }
}