#!/bin/bash

echo  "                 _____            _____                    _____                    _____                    _____ 
                /\    \          /\    \                  /\    \                  /\    \                  /\    \          
               /::\____\        /::\    \                /::\____\                /::\    \                /::\    \         
              /:::/    /       /::::\    \              /:::/    /               /::::\    \              /::::\    \        
             /:::/    /       /::::::\    \            /:::/    /               /::::::\    \            /::::::\    \       
            /:::/    /       /:::/\:::\    \          /:::/    /               /:::/\:::\    \          /:::/\:::\    \      
           /:::/    /       /:::/__\:::\    \        /:::/    /               /:::/__\:::\    \        /:::/__\:::\    \     
          /:::/    /       /::::\   \:::\    \      /:::/    /               /::::\   \:::\    \      /::::\   \:::\    \    
         /:::/    /       /::::::\   \:::\    \    /:::/    /      _____    /::::::\   \:::\    \    /::::::\   \:::\    \   
        /:::/    /       /:::/\:::\   \:::\    \  /:::/____/      /\    \  /:::/\:::\   \:::\____\  /:::/\:::\   \:::\    \  
       /:::/____/       /:::/  \:::\   \:::\____\|:::|    /      /::\____\/:::/  \:::\   \:::|    |/:::/  \:::\   \:::\____\ 
       \:::\    \       \::/    \:::\  /:::/    /|:::|____\     /:::/    /\::/   |::::\  /:::|____|\::/    \:::\  /:::/    / 
        \:::\    \       \/____/ \:::\/:::/    /  \:::\    \   /:::/    /  \/____|:::::\/:::/    /  \/____/ \:::\/:::/    /  
         \:::\    \               \::::::/    /    \:::\    \ /:::/    /         |:::::::::/    /            \::::::/    /   
          \:::\    \               \::::/    /      \:::\    /:::/    /          |::|\::::/    /              \::::/    /    
           \:::\    \              /:::/    /        \:::\__/:::/    /           |::| \::/____/               /:::/    /     
            \:::\    \            /:::/    /          \::::::::/    /            |::|  ~|                    /:::/    /      
             \:::\    \          /:::/    /            \::::::/    /             |::|   |                   /:::/    /       
              \:::\____\        /:::/    /              \::::/    /              \::|   |                  /:::/    /        
               \::/    /        \::/    /                \::/____/                \:|   |                  \::/    /         
                \/____/          \/____/                  ~~                       \|___|                   \/____/ 
                
"
# Garantir que todos os scripts individuais tenham permissão de execução
chmod +x list_group_content_types.sh list_block_types.sh list_content_types.sh list_crop_types.sh list_flagging_types.sh list_media_types.sh list_menus.sh list_paragraph_types.sh list_shortcut_sets.sh list_site_settings_types.sh list_taxonomies.sh list_enabled_modules.sh list_enabled_themes.sh list_roles.sh

# Função para exibir o menu e capturar a escolha do usuário
show_menu() {
  echo "Selecione o tipo de entidade que deseja listar:"
  options=("Block Types" "Content Types" "Crop Types" "Enabled Modules" "Flagging Types" "Group Content" "Media Types" "Menus" "Paragraph Types" "Roles" "Shortcut Sets" "Site Settings Entities" "Taxonomies" "Sair")
  select opt in "${options[@]}"
  do
    case $opt in
      "Block Types")
        ./list_block_types.sh --no-ansi | tee logs/block_types.log
        ;;
      "Content Types")
        ./list_content_types.sh --no-ansi | tee logs/content_types.log
        ;;
      "Crop Types")
        ./list_crop_types.sh --no-ansi | tee logs/crop_types.log
        ;;
      "Enabled Modules")
        ./list_enabled_modules.sh --no-ansi | tee logs/enabled_modules.log
        ;;  
      "Enabled Themes")
        ./list_enabled_themes.sh --no-ansi | tee logs/enabled_themes.log
        ;;  
      "Flagging Types")
        ./list_flagging_types.sh --no-ansi | tee logs/flagging_types.log
        ;;
      "Group Content")
        ./list_group_content_types.sh --no-ansi | tee logs/group_content_types.log
        ;;
      "Media Types")
        ./list_media_types.sh --no-ansi | tee logs/media_types.log
        ;;
      "Menus")
        ./list_menus.sh --no-ansi | tee logs/menus.log
        ;;
      "Paragraph Types")
        ./list_paragraph_types.sh --no-ansi | tee logs/paragraph_types.log
        ;;
      "Roles")
        ./list_roles.sh --no-ansi | tee logs/roles.log
        ;;
      "Shortcut Sets")
        ./list_shortcut_sets.sh --no-ansi | tee logs/shortcut_sets.log
        ;;
      "Site Settings Entities")
        ./list_site_settings_entities.sh --no-ansi | tee logs/site_settings_entities.log
        ;;
      "Taxonomies")
        ./list_taxonomies.sh --no-ansi | tee logs/taxonomies.log
        ;;
      "Sair")
        echo "Saindo..."
        break
        ;;
      *)
        echo "Opção inválida $REPLY"
        ;;
    esac
  done
}

# Mostrar o menu
show_menu

echo "Log de todas as entidades salvo na pasta logs"
