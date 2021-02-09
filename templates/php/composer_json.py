import sys

if len(sys.argv) < 2:
    raise Exception("bad arguments")

pdir = sys.argv[1]
projectname = pdir.split('/')[-2]
namespace = "Skrip42\\\\"
compj = projectname.split('-')
namespace += ''.join(x.title() for x in compj)
namespace += '\\\\'

print('{')
print('    "name":"skrip42/' + projectname + '",')
print('    "type":"",')
print('    "descrption":"",')
print('    "homepage":"https://github.com/skrip42/' + projectname + '",')
print('    "version":"v1.0.0",')
print('    "license":"MIT",')
print('    "minimum-stability":"dev",')
print('    "require":{')
print('        "php":"^7.1"')
print('    },')
print('    "authors": [')
print('        {')
print('            "name": "skrip42",')
print('            "email": "skrip42@gmail.com"')
print('        }')
print('    ],')
print('    "autoload": {')
print('        "psr-4": {')
print('            "' + namespace + '":""')
print('        }')
print('    }')
print('}')
