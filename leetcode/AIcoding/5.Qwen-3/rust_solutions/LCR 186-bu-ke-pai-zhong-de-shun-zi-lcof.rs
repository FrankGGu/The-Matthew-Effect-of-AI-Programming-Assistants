impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn determine_age(artifacts: Vec<&str>) -> Vec<String> {
        let mut map = HashMap::new();
        map.insert("青铜器", "商朝");
        map.insert("甲骨文", "商朝");
        map.insert("青花瓷", "元朝");
        map.insert("唐三彩", "唐朝");
        map.insert("兵马俑", "秦朝");
        map.insert("漆器", "周朝");
        map.insert("瓷器", "宋朝");
        map.insert("玉器", "汉朝");
        map.insert("青铜鼎", "周朝");
        map.insert("简牍", "秦朝");

        let mut result = Vec::new();
        for artifact in artifacts {
            if let Some(age) = map.get(artifact) {
                result.push(age.to_string());
            } else {
                result.push("未知".to_string());
            }
        }
        result
    }
}
}