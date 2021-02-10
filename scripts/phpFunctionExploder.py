import sys
import re
# .,+1! python3 phpFunctionExploder.py

f = sys.stdin.readline()
c = sys.stdin.readline()
f =re.split('\(|\)', f)
print(f[0] + '(')
spaces = re.search('^\s+', f[0])
spaces = spaces.group()
pr = re.split(',\s', f[1])
for i in range(0, len(pr)) :
    if i < len(pr) -1:
        print(spaces + (' ' * 4) + pr[i] + ',')
    else :
        print(spaces + (' ' * 4) + pr[i])
if re.match(r"^\s+\{\s+$", c) :
    print(spaces + ')' + f[2].strip('\n') + ' {')
else:
    print(spaces + ')' + f[2].strip('\n'))
    print(c)
