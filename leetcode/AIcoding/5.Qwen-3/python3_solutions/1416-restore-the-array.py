class Solution:
    def numberToWord(self, num: int) -> str:
        if num == 0:
            return ""
        words = []
        if num >= 100:
            words.append(self.numberToWord(num // 100) + " Hundred")
            num %= 100
        if num >= 20:
            words.append(["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"][num // 10])
            num %= 10
        if num > 0:
            words.append(["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"][num - 1])
        return " ".join(words)

    def numberToWords(self, num: int) -> str:
        if num == 0:
            return "Zero"
        words = []
        if num >= 1000000000:
            words.append(self.numberToWord(num // 1000000000) + " Billion")
            num %= 1000000000
        if num >= 1000000:
            words.append(self.numberToWord(num // 1000000) + " Million")
            num %= 1000000
        if num >= 1000:
            words.append(self.numberToWord(num // 1000) + " Thousand")
            num %= 1000
        if num > 0:
            words.append(self.numberToWord(num))
        return " ".join(words)