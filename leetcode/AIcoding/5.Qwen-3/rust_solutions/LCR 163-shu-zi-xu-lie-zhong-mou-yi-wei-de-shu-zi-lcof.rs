struct Solution {}

impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut k = k;
        let mut current = 1;
        while k > 0 {
            let steps = Self::count_steps(n, current, current + 1);
            if k > steps {
                k -= steps;
                current += 1;
            } else {
                k -= 1;
                current *= 10;
            }
        }
        current
    }

    fn count_steps(n: i32, a: i32, b: i32) -> i32 {
        let mut steps = 0;
        let mut n = n;
        let mut a = a;
        let mut b = b;
        while a <= n {
            steps += (b - a).min(n - a + 1);
            a *= 10;
            b *= 10;
        }
        steps
    }
}