#!/bin/bash

# Função para listar todos os papéis com nome, nome de máquina e quantidade de permissões
function listar_papeis {
  echo "Listando todos os papéis, nomes de máquina e a quantidade de permissões de cada um..."

  lando drush eval "
  use Drupal\user\Entity\Role;

  // Carregar todos os papéis
  \$roles = Role::loadMultiple();

  // Percorrer e exibir os detalhes de cada papel
  foreach (\$roles as \$role) {
    \$role_name = \$role->label();
    \$role_id = \$role->id();
    \$permissions = \$role->getPermissions();
    \$permission_count = count(\$permissions);
    echo \$role_name . ' (' . \$role_id . ') | ' . \$permission_count . ' permissões' . PHP_EOL;
  }
  "
}

# Chamar a função
listar_papeis
