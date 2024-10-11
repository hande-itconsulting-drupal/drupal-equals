#!/bin/bash

# Permissões problemáticas a serem removidas
permissions_to_remove=(
  "clear caches"
  ""
)

# Conectar ao banco de dados e remover associações de permissões
remove_permissions_sql() {
  for permission in "${permissions_to_remove[@]}"; do
    echo "Removing permission: $permission"
    if lando db-query "DELETE FROM role_permission WHERE permission = '$permission';"; then
      echo "SUCCESS: Removed permission: $permission"
    else
      echo "ERROR: Failed to remove permission: $permission"
    fi
  done
}

# Remover permissões
remove_permissions_sql
