#!/bin/bash

# Array de menus para deletar
menus=(
  "Main Menu"
  "Code of Ethics Main Menu EDPR"
  "Code of Ethics Main Menu EDPPT"
  "Code of Ethics Main Menu EDPBR"
  "Breadcrumbs Menu"
  "Administration"
)

# Loop através de cada menu, deletar os links de menu personalizados associados e depois deletar o menu
for menu in "${menus[@]}"; do
  echo "Deleting custom menu links in menu: $menu"
  lando drush entity:delete menu_link_content --bundle="$menu"
  echo "Deleting menu: $menu"
  lando drush entity:delete menu "$menu"
done

echo "All specified custom menu links and menus have been deleted."
