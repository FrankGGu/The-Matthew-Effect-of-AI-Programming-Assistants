from collections import defaultdict
import bisect

class TweetCounts:

    def __init__(self):
        self.tweets = defaultdict(list)

    def recordTweet(self, tweetName: str, timestamp: int) -> None:
        bisect.insort(self.tweets[tweetName], timestamp)

    def getTweetCountsPerFrequency(self, freq: str, tweetName: str, startTime: int, endTime: int) -> List[int]:
        interval = 1
        if freq == 'minute':
            interval = 60
        elif freq == 'hour':
            interval = 3600
        elif freq == 'day':
            interval = 86400

        result = []
        current = startTime
        while current <= endTime:
            next_time = current + interval
            count = bisect.bisect_left(self.tweets[tweetName], next_time) - bisect.bisect_left(self.tweets[tweetName], current)
            result.append(count)
            current = next_time

        return result