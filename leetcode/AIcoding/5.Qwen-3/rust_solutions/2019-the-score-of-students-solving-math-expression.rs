impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn score_of_students(expression: String) -> i32 {
        let mut correct = HashSet::new();
        correct.insert(10);
        correct.insert(11);
        correct.insert(12);
        correct.insert(13);
        correct.insert(14);
        correct.insert(15);
        correct.insert(16);
        correct.insert(17);
        correct.insert(18);
        correct.insert(19);
        correct.insert(20);
        correct.insert(21);
        correct.insert(22);
        correct.insert(23);
        correct.insert(24);
        correct.insert(25);
        correct.insert(26);
        correct.insert(27);
        correct.insert(28);
        correct.insert(29);
        correct.insert(30);
        correct.insert(31);
        correct.insert(32);
        correct.insert(33);
        correct.insert(34);
        correct.insert(35);
        correct.insert(36);
        correct.insert(37);
        correct.insert(38);
        correct.insert(39);
        correct.insert(40);
        correct.insert(41);
        correct.insert(42);
        correct.insert(43);
        correct.insert(44);
        correct.insert(45);
        correct.insert(46);
        correct.insert(47);
        correct.insert(48);
        correct.insert(49);
        correct.insert(50);
        correct.insert(51);
        correct.insert(52);
        correct.insert(53);
        correct.insert(54);
        correct.insert(55);
        correct.insert(56);
        correct.insert(57);
        correct.insert(58);
        correct.insert(59);
        correct.insert(60);
        correct.insert(61);
        correct.insert(62);
        correct.insert(63);
        correct.insert(64);
        correct.insert(65);
        correct.insert(66);
        correct.insert(67);
        correct.insert(68);
        correct.insert(69);
        correct.insert(70);
        correct.insert(71);
        correct.insert(72);
        correct.insert(73);
        correct.insert(74);
        correct.insert(75);
        correct.insert(76);
        correct.insert(77);
        correct.insert(78);
        correct.insert(79);
        correct.insert(80);
        correct.insert(81);
        correct.insert(82);
        correct.insert(83);
        correct.insert(84);
        correct.insert(85);
        correct.insert(86);
        correct.insert(87);
        correct.insert(88);
        correct.insert(89);
        correct.insert(90);
        correct.insert(91);
        correct.insert(92);
        correct.insert(93);
        correct.insert(94);
        correct.insert(95);
        correct.insert(96);
        correct.insert(97);
        correct.insert(98);
        correct.insert(99);
        correct.insert(100);

        let result = Self::evaluate(&expression);
        if result > 100 || result < 1 {
            return 0;
        }
        if correct.contains(&result) {
            return 1;
        }
        0
    }

    fn evaluate(expr: &str) -> i32 {
        let tokens: Vec<char> = expr.chars().filter(|c| !c.is_whitespace()).collect();
        let mut stack = vec![];
        let mut num = 0;
        for c in tokens {
            if c.is_digit(10) {
                num = num * 10 + (c as i32 - '0' as i32);
            } else {
                stack.push(num);
                stack.push(c as i32);
                num = 0;
            }
        }
        stack.push(num);

        let mut i = 0;
        while i < stack.len() {
            if stack[i] == '+' as i32 || stack[i] == '*' as i32 {
                let op = stack[i];
                let left = stack[i - 1];
                let right = stack[i + 1];
                let res = if op == '+' as i32 { left + right } else { left * right };
                stack.drain(i - 1..i + 2);
                stack.insert(i - 1, res);
                i = 0;
            } else {
                i += 1;
            }
        }

        stack[0]
    }
}
}