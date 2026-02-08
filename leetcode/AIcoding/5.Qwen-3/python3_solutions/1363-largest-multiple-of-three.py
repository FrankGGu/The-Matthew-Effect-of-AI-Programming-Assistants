class Solution:
    def largestMultipleOfThree(self, digits: List[int]) -> str:
        digits.sort(reverse=True)
        total = sum(digits)
        if total % 3 == 0:
            return ''.join(map(str, digits)) if digits else '0'
        remainder = total % 3
        for i in range(len(digits)-1, -1, -1):
            if digits[i] % 3 == remainder:
                del digits[i]
                if not digits:
                    return '0'
                return ''.join(map(str, digits)) if digits else '0'
        for i in range(len(digits)-1, -1, -1):
            if digits[i] % 3 == 1:
                del digits[i]
                for j in range(len(digits)-1, -1, -1):
                    if digits[j] % 3 == 2:
                        del digits[j]
                        if not digits:
                            return '0'
                        return ''.join(map(str, digits)) if digits else '0'
                return ''.join(map(str, digits)) if digits else '0'
        for i in range(len(digits)-1, -1, -1):
            if digits[i] % 3 == 2:
                del digits[i]
                for j in range(len(digits)-1, -1, -1):
                    if digits[j] % 3 == 1:
                        del digits[j]
                        if not digits:
                            return '0'
                        return ''.join(map(str, digits)) if digits else '0'
                return ''.join(map(str, digits)) if digits else '0'
        return '0'