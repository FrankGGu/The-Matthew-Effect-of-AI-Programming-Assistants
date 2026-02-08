class Solution:
    def maskPII(self, s: str) -> str:
        email = s.find('@')
        if email != -1:
            return s[0].lower() + '*****' + s[email-1:].lower()
        else:
            number = ''.join(c for c in s if c.isdigit())
            return '+' + '*' * (len(number) - 10) + '-***-***-' + number[-4:]