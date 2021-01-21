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
print('use Symfony\Component\Form\AbstractType;')
print('use Symfony\Component\Form\FormBuilderInterface;')
print('use Symfony\Component\Form\Extension\Core\Type\SubmitType;')
print('use Symfony\Component\Form\Extension\Core\Type\TextType;')
print('')
print( 'class ' + php_template_utils.createClassName(fileName) + ' extends AbstractType')
print('{')
print('    public function buildForm(FormBuilderInterface $builder, array $options)')
print('    {')
print('        $builder')
print('            ->add(')
print("                'submit',")
print("                SubmitType::class,")
print('                [')
print("                    'label' => 'Submit'")
print('                ]')
print('            );')
print('    }')
print('}')
