#!/bin/bash

# Listar todos os módulos habilitados com nome, nome de máquina e versão
echo "Listing all enabled modules with names and versions:"
lando drush pml --status=enabled --type=module --no-ansi | grep -E '^\s+\S+' | awk -F'  +' '{print $3 " | " $5}' | sort
