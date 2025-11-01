#!/bin/bash

# List of groups to delete
groups=(
  "Gryffindor Students"
  "Slytherin Students"
  "Ravenclaw Students"
  "Hufflepuff Students"
  "Hogwarts Staff"
)

# Loop through each group and delete it
for group in "${groups[@]}"
do
  echo "Deleting group: $group"
  az ad group delete --group "$group"
done
