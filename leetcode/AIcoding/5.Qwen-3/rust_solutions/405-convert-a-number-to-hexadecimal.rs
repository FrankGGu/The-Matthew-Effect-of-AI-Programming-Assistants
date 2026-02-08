struct Solution {}

impl Solution {
    pub fn to_hex(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut num = num;
        let mut result = String::new();
        let hex_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];
        while num != 0 {
            let index = (num & 0xf) as usize;
            result.insert(0, hex_chars[index]);
            num >>= 4;
        }
        result
    }
}