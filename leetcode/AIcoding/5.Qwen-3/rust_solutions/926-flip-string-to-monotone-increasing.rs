impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let mut flip = 0;
        let mut ones = 0;
        for c in s.chars() {
            if c == '1' {
                ones += 1;
            } else {
                flip += 1;
                if ones < flip {
                    flip = ones;
                }
            }
        }
        flip
    }
}