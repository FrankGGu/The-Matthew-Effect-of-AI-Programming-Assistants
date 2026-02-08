struct Solution;

impl Solution {
    pub fn fire_works(operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut stack = Vec::new();
        let mut result = Vec::new();

        for op in operations {
            match op[0] {
                1 => {
                    let x = op[1];
                    stack.push(x);
                },
                2 => {
                    if let Some(val) = stack.pop() {
                        result.push(val);
                    }
                },
                _ => {}
            }
        }

        result
    }
}