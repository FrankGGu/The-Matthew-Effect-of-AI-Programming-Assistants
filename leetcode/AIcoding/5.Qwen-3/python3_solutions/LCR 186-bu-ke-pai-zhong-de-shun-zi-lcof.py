class Solution:
    def guessYear(self, year: int) -> str:
        if year < 100:
            return "Ancient"
        elif 100 <= year < 500:
            return "Six Dynasties"
        elif 500 <= year < 1000:
            return "Tang"
        elif 1000 <= year < 1300:
            return "Song"
        elif 1300 <= year < 1600:
            return "Ming"
        else:
            return "Qing"