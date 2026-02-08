class Solution:
    def fullJustify(self, words: list[str], max_width: int) -> list[str]:
        result = []
        current_line = []
        current_length = 0

        for word in words:
            if current_length + len(word) + len(current_line) > max_width:
                spaces = max_width - current_length
                if len(current_line) == 1:
                    line = current_line[0] + ' ' * spaces
                else:
                    base_space = spaces // (len(current_line) - 1)
                    extra_space = spaces % (len(current_line) - 1)
                    line = ''
                    for i in range(len(current_line) - 1):
                        line += current_line[i] + ' ' * base_space
                        if extra_space > 0:
                            line += ' '
                            extra_space -= 1
                    line += current_line[-1]
                result.append(line)
                current_line = [word]
                current_length = len(word)
            else:
                current_line.append(word)
                current_length += len(word)

        line = ' '.join(current_line)
        line += ' ' * (max_width - len(line))
        result.append(line)

        return result