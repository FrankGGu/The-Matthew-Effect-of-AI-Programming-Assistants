impl Solution {
    pub fn min_array_end(mut n: i64, mut m: i64) -> i64 {
        let mut i = 0;
        while m > 0 {
            if (n & (1 << i)) == 0 {
                if (m & (1 << i)) != 0 {
                    n |= (1 << i);
                }
            }
            m >>= 1;
            i += 1;
        }
        n
    }
}