class Solution:
    def reportSpam(self, message: str, bannedWords: List[str]) -> bool:
        banned = set(bannedWords)
        count = 0
        for word in message.split():
            if word in banned:
                count += 1
                if count >= 2:
                    return True
        return False