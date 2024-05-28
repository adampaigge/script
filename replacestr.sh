#!/bin/bash
find . -iname "*Novo-1.14*" | while read -r file; do
  # Generate new file name by replacing 'bar' with 'foo'
  newname=$(echo "$file" | sed 's/Novo-1.14/Script/')
  
  # Print the move command for verification
  mv "$file" "$newname"
done
