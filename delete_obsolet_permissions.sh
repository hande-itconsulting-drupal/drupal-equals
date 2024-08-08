#!/bin/bash

# Permissões problemáticas a serem removidas
permissions_to_remove=(
  "access memcache statistics"
  "access slab cachedump"
  "administer google tag manager"
  "administer hsts"
  "administer migrations"
  "clear caches"
  "create encontros_2020 site setting"
  "delete encontros_2020 site setting"
  "disable textfield module"
  "edit encontros_2020 site setting"
  "restful get user_picture_update"
  "restful patch person_picture_update"
  "restful post user_picture_update"
  "view published encontros_2020 site setting entities"
  "view unpublished encontros_2020 site setting entities"
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
