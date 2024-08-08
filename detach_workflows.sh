#!/bin/bash

# Função para desatachar workflows das entidades
detach_workflows() {
  workflow_name=$1
  total_entities=$(lando drush sql-query "SELECT COUNT(*) FROM content_moderation_state_field_data WHERE workflow = '$workflow_name';" | grep -Eo '[0-9]+')
  detached_entities=0
  log_file="detached_workflows_$workflow_name.log"
  echo "" > "$log_file" # Limpar o log anterior

  if [ -z "$total_entities" ]; then
    echo "Erro ao obter o total de entidades para o workflow: $workflow_name"
    return
  fi

  echo "Total de entidades para $workflow_name: $total_entities"

  # Barra de progresso
  show_progress() {
    local progress=$1
    local total=$2
    local percent=$(( 100 * progress / total ))
    local bar_length=50
    local filled_length=$(( bar_length * progress / total ))
    local empty_length=$(( bar_length - filled_length ))

    printf "\r["
    for ((i=0; i<filled_length; i++)); do printf "="; done
    for ((i=0; i<empty_length; i++)); do printf " "; done
    printf "] %s%% (%s/%s)" "$percent" "$progress" "$total"
  }

  while :; do
    # Listar todas as entidades que utilizam este workflow na tabela content_moderation_state_field_data
    entities=$(lando drush sql-query "SELECT content_entity_id FROM content_moderation_state_field_data WHERE workflow = '$workflow_name' LIMIT 10;" | grep -Eo '[0-9]+')

    # Se nenhuma entidade for encontrada, sair do loop
    if [ -z "$entities" ]; then
      break
    fi

    while read -r entity; do
      if [ -n "$entity" ]; then
        lando drush sql-query "UPDATE content_moderation_state_field_data SET workflow = NULL WHERE content_entity_id = '$entity' AND workflow = '$workflow_name';"
        echo "$entity" >> "$log_file"
        detached_entities=$((detached_entities + 1))
        # Atualizar a barra de progresso
        show_progress "$detached_entities" "$total_entities"
      fi
    done <<< "$entities"
  done

  echo -ne "\n"
  echo "Todas as entidades desatachadas do workflow: $workflow_name"
  echo "Log de entidades desatachadas salvo em: $log_file"
}

# Array de workflows a serem desatachados
workflows=(
  "workflow_for_news_hints_and_events"
  "global"
)

# Loop através de cada workflow e desatachar as entidades associadas
for workflow in "${workflows[@]}"; do
  detach_workflows "$workflow"
done

echo "Processo de desatachamento de workflows concluído."
