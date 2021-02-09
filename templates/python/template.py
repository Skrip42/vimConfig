import sys

print('import sys')
print
print('if len(sys.argv) < 2:')
print("    raise Exception('bad arguments')")
print
print('filePath   = sys.argv[1]')
print("fileName   = filePath.split('/').pop()")
print('projectDir = sys.argv[2]')
print("projectDir = projectDir.replace(filePath, '')")
print("filePath   = filePath.replace(fileName, '')")
