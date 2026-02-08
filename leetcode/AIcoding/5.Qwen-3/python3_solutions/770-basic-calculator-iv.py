class Solution:
    def basicCalculatorIV(self, expression: str, evalvars: List[str], evalints: List[int]) -> List[str]:
        import re
        from collections import defaultdict

        def parse(expression):
            i = 0
            def parse_expr():
                nonlocal i
                res = parse_term()
                while i < len(expression) and expression[i] == '+':
                    i += 1
                    res = res + parse_term()
                return res
            def parse_term():
                nonlocal i
                res = parse_factor()
                while i < len(expression) and expression[i] == '*':
                    i += 1
                    res = res * parse_factor()
                return res
            def parse_factor():
                nonlocal i
                if expression[i] == '(':
                    i += 1
                    res = parse_expr()
                    i += 1
                    return res
                elif expression[i] == '-':
                    i += 1
                    return -parse_factor()
                else:
                    num = ''
                    while i < len(expression) and (expression[i].isdigit() or expression[i].isalpha()):
                        num += expression[i]
                        i += 1
                    if num.isdigit():
                        return Constant(int(num))
                    else:
                        return Variable(num)
            return parse_expr()

        class Expression:
            def __add__(self, other):
                return Add(self, other)
            def __sub__(self, other):
                return Sub(self, other)
            def __mul__(self, other):
                return Mul(self, other)
            def __neg__(self):
                return Neg(self)
            def eval(self, vars_dict):
                pass
            def to_list(self):
                pass

        class Constant(Expression):
            def __init__(self, value):
                self.value = value
            def eval(self, vars_dict):
                return self.value
            def to_list(self):
                return [str(self.value)]

        class Variable(Expression):
            def __init__(self, name):
                self.name = name
            def eval(self, vars_dict):
                return vars_dict[self.name]
            def to_list(self):
                return [self.name]

        class Add(Expression):
            def __init__(self, left, right):
                self.left = left
                self.right = right
            def eval(self, vars_dict):
                return self.left.eval(vars_dict) + self.right.eval(vars_dict)
            def to_list(self):
                left_list = self.left.to_list()
                right_list = self.right.to_list()
                result = []
                for l in left_list:
                    for r in right_list:
                        result.append(l + '+' + r)
                return result

        class Sub(Expression):
            def __init__(self, left, right):
                self.left = left
                self.right = right
            def eval(self, vars_dict):
                return self.left.eval(vars_dict) - self.right.eval(vars_dict)
            def to_list(self):
                left_list = self.left.to_list()
                right_list = self.right.to_list()
                result = []
                for l in left_list:
                    for r in right_list:
                        result.append(l + '-' + r)
                return result

        class Mul(Expression):
            def __init__(self, left, right):
                self.left = left
                self.right = right
            def eval(self, vars_dict):
                return self.left.eval(vars_dict) * self.right.eval(vars_dict)
            def to_list(self):
                left_list = self.left.to_list()
                right_list = self.right.to_list()
                result = []
                for l in left_list:
                    for r in right_list:
                        result.append(l + '*' + r)
                return result

        class Neg(Expression):
            def __init__(self, expr):
                self.expr = expr
            def eval(self, vars_dict):
                return -self.expr.eval(vars_dict)
            def to_list(self):
                expr_list = self.expr.to_list()
                result = []
                for e in expr_list:
                    result.append('-' + e)
                return result

        vars_dict = dict(zip(evalvars, evalints))
        expr = parse(expression)
        result = expr.to_list()
        result.sort(key=lambda x: (-len(x), x))
        final_result = []
        seen = set()
        for item in result:
            if item not in seen:
                seen.add(item)
                final_result.append(item)
        return final_result