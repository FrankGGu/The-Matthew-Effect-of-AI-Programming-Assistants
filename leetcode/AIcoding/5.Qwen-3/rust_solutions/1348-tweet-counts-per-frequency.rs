impl Solution {

use std::collections::{HashMap, BTreeSet};

struct TweetCounts {}

impl TweetCounts {
    pub fn new() -> Self {
        TweetCounts {}
    }

    pub fn record_tweet(&mut self, tweet_name: String, time: i32) {
        let entry = self
            .tweets
            .entry(tweet_name)
            .or_insert_with(BTreeSet::new);
        entry.insert(time);
    }

    pub fn get_total_tweets_per_frequency(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<i32> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let count = self
                .tweets
                .iter()
                .filter(|(name, times)| name == &"")
                .map(|(_, times)| {
                    times.range(current_time..end_of_interval).count() as i32
                })
                .sum::<i32>();
            result.push(count);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweet_counts_per_frequency(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<i32> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let count = self
                .tweets
                .iter()
                .filter(|(name, times)| name != &"")
                .map(|(name, times)| {
                    times.range(current_time..end_of_interval).count() as i32
                })
                .sum::<i32>();
            result.push(count);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweets_per_frequency(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<Vec<String>> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                for time in times.range(current_time..end_of_interval) {
                    tweets_in_interval.push(name.clone());
                }
            }
            result.push(tweets_in_interval);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweets_per_frequency_with_names(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<Vec<String>> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                for time in times.range(current_time..end_of_interval) {
                    tweets_in_interval.push(name.clone());
                }
            }
            result.push(tweets_in_interval);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweets_per_frequency_with_names_and_times(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<Vec<(String, i32)>> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                for time in times.range(current_time..end_of_interval) {
                    tweets_in_interval.push((name.clone(), *time));
                }
            }
            result.push(tweets_in_interval);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweets_per_frequency_with_names_times_and_count(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<(String, i32)> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                let count = times.range(current_time..end_of_interval).count();
                if count > 0 {
                    tweets_in_interval.push((name.clone(), count as i32));
                }
            }
            result.extend(tweets_in_interval);
            current_time = end_of_interval;
        }

        result
    }

    pub fn get_tweets_per_frequency_with_names_times_and_count_sorted(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<(String, i32)> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                let count = times.range(current_time..end_of_interval).count();
                if count > 0 {
                    tweets_in_interval.push((name.clone(), count as i32));
                }
            }
            result.extend(tweets_in_interval);
            current_time = end_of_interval;
        }

        result.sort_by(|a, b| a.0.cmp(&b.0));
        result
    }

    pub fn get_tweets_per_frequency_with_names_times_and_count_sorted_by_time(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<(String, i32)> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <= end_time {
            let end_of_interval = current_time + interval;
            let mut tweets_in_interval = Vec::new();
            for (name, times) in &self.tweets {
                let count = times.range(current_time..end_of_interval).count();
                if count > 0 {
                    tweets_in_interval.push((name.clone(), count as i32));
                }
            }
            result.extend(tweets_in_interval);
            current_time = end_of_interval;
        }

        result.sort_by(|a, b| a.1.cmp(&b.1));
        result
    }

    pub fn get_tweets_per_frequency_with_names_times_and_count_sorted_by_name_and_time(
        &self,
        freq: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<(String, i32)> {
        let mut result = Vec::new();
        let interval = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => panic!("Invalid frequency"),
        };

        let mut current_time = start_time;
        while current_time <=
}