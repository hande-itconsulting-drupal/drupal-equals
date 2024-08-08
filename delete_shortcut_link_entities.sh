#!/bin/bash

# Nome correto da entidade "Shortcut link"
entity_type="shortcut"

# Nome do conjunto de atalhos (Shortcut set)
shortcut_set="default"

# Deletar todas as entidades de "Shortcut link" associadas ao conjunto de atalhos "Default"
echo "Deleting shortcut link entities of shortcut set: $shortcut_set"
lando drush eval "
\$links = \Drupal::entityTypeManager()->getStorage('$entity_type')->loadByProperties(['shortcut_set' => '$shortcut_set']);
foreach (\$links as \$link) {
  \$link->delete();
}
"

echo "All shortcut link entities of shortcut set $shortcut_set have been deleted."
