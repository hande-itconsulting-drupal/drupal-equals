#!/bin/bash

# Executar o comando drush eval para listar todos os menus e a contagem de links
echo "Listando todos os menus e a contagem de links:"
lando drush eval "
\$menus = \Drupal::entityTypeManager()->getStorage('menu')->loadMultiple();
foreach (\$menus as \$menu) {
    \$menu_id = \$menu->id();
    \$menu_label = \$menu->label();
    \$link_count = \Drupal::entityQuery('menu_link_content')->condition('menu_name', \$menu_id)->count()->execute();
    echo \$menu_label . ' (' . \$menu_id . ') | ' . \$link_count . ' links' . PHP_EOL;
}"
