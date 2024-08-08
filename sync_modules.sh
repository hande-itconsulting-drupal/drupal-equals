#!/bin/bash

# Comando que gera a lista: 
lando drush pml --status=enabled --type=module --field=name --no-ansi | sort > enabled_modules_D01.log

# Arquivos de listas de módulos
D01_MODULES_FILE="enabled_modules_D01.log"
PROD_MODULES_FILE="enabled_modules_prod.log" # Necessário estar já neste diretório, a lista da base contra a qual se quer comparar. No nosso caso, a listagem de PROD. 

# Módulos a habilitar e desabilitar
MODULES_TO_ENABLE=()
MODULES_TO_DISABLE=()

# Ler módulos habilitados em D01
while IFS= read -r module; do
    D01_MODULES+=("$module")
done < "$D01_MODULES_FILE"

# Ler módulos habilitados em Produção
while IFS= read -r module; do
    PROD_MODULES+=("$module")
done < "$PROD_MODULES_FILE"

# Encontrar módulos que precisam ser habilitados em D01
for module in "${PROD_MODULES[@]}"; do
    if [[ ! " ${D01_MODULES[@]} " =~ " ${module} " ]]; then
        MODULES_TO_ENABLE+=("$module")
    fi
done

# Encontrar módulos que precisam ser desabilitados em D01
for module in "${D01_MODULES[@]}"; do
    if [[ ! " ${PROD_MODULES[@]} " =~ " ${module} " ]]; then
        MODULES_TO_DISABLE+=("$module")
    fi
done

# Habilitar módulos ausentes
if [ ${#MODULES_TO_ENABLE[@]} -ne 0 ]; then
    echo "Habilitando módulos ausentes em D01..."
    for module in "${MODULES_TO_ENABLE[@]}"; do
        echo "Habilitando módulo: $module"
        lando drush en -y "$module"
    done
else
    echo "Nenhum módulo a ser habilitado."
fi

# Desabilitar módulos extras
if [ ${#MODULES_TO_DISABLE[@]} -ne 0 ]; then
    echo "Desabilitando módulos extras em D01..."
    for module in "${MODULES_TO_DISABLE[@]}"; do
        echo "Desabilitando módulo: $module"
        lando drush pm-uninstall -y "$module"
    done
else
    echo "Nenhum módulo a ser desabilitado."
fi

echo "Processo de sincronização de módulos concluído."
