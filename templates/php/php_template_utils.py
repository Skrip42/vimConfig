import json
import os
import re
def sliceindex(x):
    i = 0
    for c in x:
        if c.isalpha():
            i = i + 1
            return i
        i = i + 1

def upperfirst(x):
    i = sliceindex(x)
    return x[:i].upper() + x[i:]

def prepareAutoload(projectDir, filePath):
    if os.path.isfile(projectDir + 'composer.json') :
        with open(projectDir + 'composer.json') as composerJson:
            composer = json.load(composerJson)
        autoload = composer['autoload']['psr-4']
        if 'autoload-dev' in composer.keys() :
            autoload.update(composer['autoload-dev']['psr-4'])
        return autoload
    return {}

def createNamespace(projectDir, filePath):
    autoload = prepareAutoload(projectDir, filePath)

    namespace = filePath
    for key in autoload :
        if autoload[key] == '' :
            namespace = key + namespace
        else :
            namespace = namespace.replace(autoload[key], key)

    namespace = namespace.split('/')
    for nms in namespace :
        if len(nms) :
            nms = nms[0].title() + nms[1:]
        # namespace[key] = namespace[key][0].title() + namespace[key][1:]
    namespace = '\\'.join(namespace)
    namespace = namespace.strip('\\')
    # namespace = namespace.join('\\')
    # namespace = namespace.title().replace('/', '\\').strip('\\')
    # namespace = namespace.title().replace('/', '\\').strip('\\')
    return namespace

def createClassName(fileName):
    return fileName.replace('.php', '')

def createRoute(projectDir, filePath, fileName):
    autoload = prepareAutoload(projectDir, filePath)
    routePath = filePath
    for key in autoload :
        routePath = routePath.replace(autoload[key], '')
    routePath = routePath.replace('Controller', '')
    fileName = fileName.replace('Controller.php', '')
    fileName = re.sub(r'(?<!^)(?=[A-Z])', '_', fileName).lower()
    return [routePath + fileName, fileName ]

def createCommandName(fileName):
    fileName = fileName.replace('Command.php', '')
    fileName = re.sub(r'(?<!^)(?=[A-Z])', '-', fileName).lower()
    return fileName
