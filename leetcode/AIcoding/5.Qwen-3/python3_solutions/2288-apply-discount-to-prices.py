class Solution:
    def discountPrices(self, sentence: str, discount: int) -> str:
        words = sentence.split()
        for i in range(len(words)):
            if words[i][0] == '$' and words[i][1:].isdigit():
                price = int(words[i][1:])
                discounted = price * (100 - discount) / 100
                words[i] = f"${discounted:.2f}"
        return ' '.join(words)