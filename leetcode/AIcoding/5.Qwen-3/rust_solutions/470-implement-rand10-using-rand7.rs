struct Solution {}

impl Solution {
    fn rand7() -> i32 {
        unimplemented!()
    }

    fn rand10() -> i32 {
        let mut val = 0;
        loop {
            val = (rand7() - 1) * 7 + rand7();
            if val <= 40 {
                break;
            }
        }
        val % 10 + 1
    }
}