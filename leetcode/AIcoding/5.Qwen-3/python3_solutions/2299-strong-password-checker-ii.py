class Solution:
    def strongPasswordCheckerII(self, password: str) -> bool:
        if len(password) < 6:
            return False
        has_lower = has_upper = has_digit = has_special = False
        for i, c in enumerate(password):
            if c.islower():
                has_lower = True
            elif c.isupper():
                has_upper = True
            elif c.isdigit():
                has_digit = True
            elif c in "!@#$%^&*()_+{}[]|\\`~":
                has_special = True
            if i > 0 and c == password[i - 1]:
                return False
        return has_lower and has_upper and has_digit and has_special