import json
import os
import re

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

    namespace = namespace.title().replace('/', '\\').strip('\\')
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
