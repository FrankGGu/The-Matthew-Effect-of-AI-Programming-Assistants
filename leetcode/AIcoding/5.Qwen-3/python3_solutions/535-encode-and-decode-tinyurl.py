class Codec:
    def __init__(self):
        self.url_map = {}
        self.short_url_prefix = "http://tinyurl.com/"

    def encode(self, longUrl: str) -> str:
        short_url = self.short_url_prefix + str(len(self.url_map))
        self.url_map[short_url] = longUrl
        return short_url

    def decode(self, shortUrl: str) -> str:
        return self.url_map[shortUrl]