import sys
import cpp_template_utils

if len(sys.argv) < 2:
    raise Exception('bad arguments')

filePath   = sys.argv[1]
fileName   = filePath.split('/').pop()
projectDir = sys.argv[2]
projectDir = projectDir.replace(filePath, '')
filePath   = filePath.replace(fileName, '')

print("#ifndef " + cpp_template_utils.createDefine(filePath, fileName))
print("#define " + cpp_template_utils.createDefine(filePath, fileName))
print
print("namespace " + cpp_template_utils.createNamespace(filePath, fileName))
print("{")
print("    class " + cpp_template_utils.createClassName(fileName))
print("    {")
print("        public:")
print("            " + cpp_template_utils.createClassName(fileName) + "() {};")
print("        private:")
print("    };")
print("}")
print
print("#endif /* " + cpp_template_utils.createDefine(filePath, fileName) + " */")
