import sys
import php_template_utils

if len(sys.argv) < 2:
    raise Exception('bad arguments')

filePath   = sys.argv[1]
fileName   = filePath.split('/').pop()
projectDir = sys.argv[2]
projectDir = projectDir.replace(filePath, '')
filePath   = filePath.replace(fileName, '')

print('<?php')
# print(filePath)
# print(projectDir)
print('namespace ' + php_template_utils.createNamespace(projectDir, filePath) + ';')
print('')
print('use Exception;')
print('')
print( 'class ' + php_template_utils.createClassName(fileName) + ' extends Exception')
print('{')
print('}')
