#!/bin/bash

echo "Listando todos os tipos de Content block:"
lando drush eval "
\$block_types = \Drupal::entityTypeManager()->getStorage('block_content_type')->loadMultiple();
foreach (\$block_types as \$type) {
  echo \$type->label() . ' (' . \$type->id() . ')' . PHP_EOL;
}
"
