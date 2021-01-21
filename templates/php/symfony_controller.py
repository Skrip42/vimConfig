import sys
import json
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
print('use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;')
print('use Symfony\Component\HttpFoundation\Response;')
print('use Symfony\Component\HttpFoundation\Request;')
print('use Symfony\Component\HttpFoundation\RedirectResponse;')
print('use Symfony\Component\HttpFoundation\JsonResponse;')
print('use Symfony\Component\Routing\Annotation\Route;')
print('use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;')
print('')
route = php_template_utils.createRoute(projectDir, filePath, fileName)
print('/**')
print(' * @Route("' + route[0] + '", name="' + route[1] + '")')
print(' * @IsGranted("ROLE_ADMIN")')
print(' */')
print('class ' + php_template_utils.createClassName(fileName) + ' extends AbstractController')
print('{')
print('}')
