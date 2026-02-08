from collections import defaultdict, OrderedDict

class LFUCache:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = {}
        self.freq = defaultdict(OrderedDict)
        self.min_freq = 0
        self.size = 0

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        value, freq = self.cache[key]
        del self.freq[freq][key]
        if not self.freq[freq]:
            del self.freq[freq]
            if self.min_freq == freq:
                self.min_freq += 1
        self.freq[freq + 1][key] = value
        self.cache[key] = (value, freq + 1)
        return value

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return
        if key in self.cache:
            old_value, freq = self.cache[key]
            del self.freq[freq][key]
            if not self.freq[freq]:
                del self.freq[freq]
                if self.min_freq == freq:
                    self.min_freq += 1
        else:
            if self.size >= self.capacity:
                # Evict the least frequently used item
                lfu_key, lfu_value = self.freq[self.min_freq].popitem(last=False)
                del self.cache[lfu_key]
                self.size -= 1
            self.size += 1
        self.freq[1][key] = value
        self.cache[key] = (value, 1)
        self.min_freq = 1