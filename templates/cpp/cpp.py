import sys
import cpp_template_utils

if len(sys.argv) < 2:
    raise Exception('bad arguments')

filePath   = sys.argv[1]
fileName   = filePath.split('/').pop()
projectDir = sys.argv[2]
projectDir = projectDir.replace(filePath, '')
filePath   = filePath.replace(fileName, '')

print('#include "' + cpp_template_utils.createHeaderName(fileName) + '"')
print("")
print("namespace " + cpp_template_utils.createNamespace(filePath, fileName))
print("{")
print("}")
