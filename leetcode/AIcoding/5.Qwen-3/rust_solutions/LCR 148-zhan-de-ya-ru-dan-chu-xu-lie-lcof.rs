struct Solution;

impl Solution {
    pub fn validate_stack_sequences(pushed: Vec<i32>, popped: Vec<i32>) -> bool {
        let mut stack = Vec::new();
        let mut index = 0;

        for &num in &pushed {
            stack.push(num);

            while let Some(&top) = stack.last() {
                if top == popped[index] {
                    stack.pop();
                    index += 1;
                } else {
                    break;
                }
            }
        }

        index == popped.len()
    }
}