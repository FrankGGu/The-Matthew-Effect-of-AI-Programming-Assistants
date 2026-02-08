class StreamChecker:

    def __init__(self, words):
        self.trie = {}
        self.max_len = 0
        self.queue = []

        for word in words:
            self.max_len = max(self.max_len, len(word))
            node = self.trie
            for ch in word:
                if ch not in node:
                    node[ch] = {}
                node = node[ch]
            node['#'] = True

    def query(self, ch):
        self.queue.append(ch)
        if len(self.queue) > self.max_len:
            self.queue.pop(0)
        node = self.trie
        for ch in self.queue:
            if ch in node:
                node = node[ch]
                if '#' in node:
                    return True
            else:
                return False
        return False