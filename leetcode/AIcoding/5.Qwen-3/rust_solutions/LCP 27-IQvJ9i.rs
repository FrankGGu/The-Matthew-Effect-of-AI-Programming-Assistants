struct Solution;

impl Solution {
    pub fn mirror_reflection(mut e: i32, mut f: i32) -> i32 {
        while e % 2 == 0 && f % 2 == 0 {
            e /= 2;
            f /= 2;
        }
        if e % 2 == 0 && f % 2 == 1 {
            return 2;
        } else if e % 2 == 1 && f % 2 == 0 {
            return 1;
        } else {
            return 0;
        }
    }
}