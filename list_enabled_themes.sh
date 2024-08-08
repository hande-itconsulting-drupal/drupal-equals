#!/bin/bash

# Listar todos os módulos habilitados com nome, nome de máquina e versão
echo "Listing all enabled modules with names and versions:"
lando drush pml --status=enabled --type=theme --no-ansi
