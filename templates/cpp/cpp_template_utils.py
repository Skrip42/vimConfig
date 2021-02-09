def createNamespace(filePath, fileName):
    namespace = filePath.replace('/', '_')
    namespace += fileName.replace('.h', '').replace('.cpp', '')
    namespace = namespace.lower()
    return namespace

def createDefine(filePath, fileName):
    namespace = filePath.replace('/', '_')
    namespace += fileName.replace('.', '_')
    namespace = namespace.upper()
    return namespace

def createClassName(fileName):
    return fileName.replace('.h', '').replace('.cpp', '')

def createHeaderName(fileName):
    return fileName.replace('.cpp', '').replace('.h', '') + '.h'
