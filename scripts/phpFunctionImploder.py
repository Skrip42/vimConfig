import sys
import re
# '<,'>! python3 phpFunctionExploder.py
result = sys.stdin.readline().strip('\n');
spaces = re.search('^\s+', result)
spaces = spaces.group()
pr = False
for line in sys.stdin :
    result += line.strip('\n').strip(' ')
result = result.replace(',', ', ')
if result[-1] == '{' :
    pr = True
    result = result.replace(' {', '')
print(result)
if pr :
    print(spaces + '{')
