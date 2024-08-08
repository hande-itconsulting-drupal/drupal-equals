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
chmod +x fix_groups_content_types_labels.sh fix_invalid_permissions.sh

# Função para exibir o menu e capturar a escolha do usuário
show_menu() {
  echo "Selecione o bug que deseja corrigir:"
  options=("Labels in Group Content types" "Invalid Permissions" "Sair")
  select opt in "${options[@]}"
  do
    case $opt in
      "Labels in Group Content types")
        ./fix_groups_content_types_labels.sh --no-ansi | tee logs/fix_groups_content_types_labels.log
        ;;
      "Invalid Permissions")
        ./fix_invalid_permissions.sh --no-ansi | tee logs/fix_invalid_permissions.log
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

echo "Log de todos os bugs corrigidos disponível."
