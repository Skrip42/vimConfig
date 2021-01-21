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
print('namespace ' + php_template_utils.createNamespace(projectDir, filePath) + ';')
print('')
print('class ' + php_template_utils.createClassName(fileName))
print('{')
print('}')
