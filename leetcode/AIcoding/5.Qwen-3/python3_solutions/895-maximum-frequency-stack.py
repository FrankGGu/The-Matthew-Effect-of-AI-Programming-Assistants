class FreqStack:

    def __init__(self):
        self.freq = {}
        self.group = {}
        self.max_freq = 0

    def push(self, val: int) -> None:
        self.freq[val] = self.freq.get(val, 0) + 1
        current_freq = self.freq[val]
        if current_freq > self.max_freq:
            self.max_freq = current_freq
        if current_freq not in self.group:
            self.group[current_freq] = []
        self.group[current_freq].append(val)

    def pop(self) -> int:
        val = self.group[self.max_freq].pop()
        self.freq[val] -= 1
        if not self.group[self.max_freq]:
            self.max_freq -= 1
        return val