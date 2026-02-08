class WordFilter:
    def __init__(self, words):
        self.map = {}
        for word in words:
            for i in range(len(word) + 1):
                for j in range(len(word) + 1):
                    prefix = word[:i]
                    suffix = word[j:]
                    self.map[(prefix, suffix)] = word

    def f(self, prefix, suffix):
        return self.map.get((prefix, suffix), -1)