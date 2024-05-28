#!/bin/bash
find . -iname "*novo*" | while read -r file; do
  # Generate new file name by replacing 'bar' with 'foo'
  newname=$(echo "$file" | sed 's/novo/script/')
  
  # Print the move command for verification
  mv "$file" "$newname"
done
