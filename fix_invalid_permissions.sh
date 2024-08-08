#!/bin/bash

# Função para corrigir permissões inválidas de todos os papéis
function corrigir_permissoes_invalidas {
  echo "Corrigindo permissões inválidas para todos os papéis existentes..."

  lando drush eval "
  use Drupal\user\Entity\Role;

  // Carregar todos os papéis
  \$roles = Role::loadMultiple();

  // Listar todas as permissões existentes
  \$all_permissions = array_keys(\Drupal::service('user.permissions')->getPermissions());

  foreach (\$roles as \$role) {
    // Obter as permissões atuais do papel
    \$current_permissions = \$role->getPermissions();

    // Inicializar array de permissões válidas e removidas
    \$valid_permissions = [];
    \$removed_permissions = [];

    // Percorrer todas as permissões atuais do papel
    foreach (\$current_permissions as \$permission) {
      // Verificar se a permissão está na lista de permissões existentes
      if (in_array(\$permission, \$all_permissions)) {
        // Adicionar à lista de permissões válidas
        \$valid_permissions[] = \$permission;
      } else {
        // Adicionar à lista de permissões removidas
        \$removed_permissions[] = \$permission;
      }
    }

    // Definir as permissões válidas de volta ao papel
    \$role->set('permissions', \$valid_permissions);

    // Salvar o papel
    \$role->save();

    // Exibir permissões removidas
    if (!empty(\$removed_permissions)) {
      echo 'Papel ' . \$role->id() . ' (' . \$role->label() . '): ' . implode(', ', \$removed_permissions) . ' removidas' . PHP_EOL;
    }
  }

  echo 'Todas as permissões inválidas foram removidas dos papéis existentes.';
  "
}

# Chamar a função para corrigir permissões inválidas
corrigir_permissoes_invalidas
