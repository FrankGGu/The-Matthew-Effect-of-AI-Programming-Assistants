struct Solution;

impl Solution {
    pub fn defang_ip_addr(address: String) -> String {
        address.replace(".", "[.]")
    }
}