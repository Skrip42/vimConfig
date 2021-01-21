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
print('use Symfony\Component\Console\Command\Command;')
print('use Symfony\Component\Console\Input\InputInterface;')
print('use Symfony\Component\Console\Output\OutputInterface;')
print('')
print( 'class ' + php_template_utils.createClassName(fileName) + ' extends Command')
print('{')
commandName = php_template_utils.createCommandName(fileName)
print('    protected static $defaultName = "app:' + commandName + '";')
print('    protected function configure()')
print('    {')
print('        $this->setDescription("' + commandName+ ' command");')
print('    }')
print('    protected function execute(InputInterface $input, OutputInterface $output)')
print('    {')
print('        return Command::SUCCESS;')
print('    }')
print('}')
