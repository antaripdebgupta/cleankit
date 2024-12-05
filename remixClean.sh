#!/bin/bash

remix_files=("public/logo-dark.png" "public/logo-light.png")

remove_remix_files() {
  local path=$1

  for file in "${remix_files[@]}"; do
    target="$path/$file"
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Removed: $file"
    else
      echo "Already removed: $file"
    fi
  done
}

clean_remix_file() {
  local project_dir=$1
  local app_file="$project_dir/app/routes/_index.tsx"

  if [[ -f "$app_file" ]]; then
    # Remove everything inside the return statement and replace with <div></div>
    if ! grep -q '<div></div>' "$app_file"; then
      sed -i '/return (/,/);/c\  return (\n    <div></div>\n  );' "$app_file"
      echo "Cleaned: return statement in $app_file"
    else
      echo "Return statement already cleaned in $app_file."
    fi

    # Remove the resources array
    if grep -q 'const resources = \[' "$app_file"; then
      sed -i '/const resources = \[/,/\];/d' "$app_file"
      echo "Removed resources array from $app_file"
    else
      echo "Resources array already removed or not present in $app_file."
    fi

    # User to update the meta information
    if grep -q 'title: "New Remix App"' "$app_file"; then
      read -p "Would you like to update the meta information? (yes/no): " update_meta
      if [[ "$update_meta" == "yes" ]]; then
        read -p "Enter new title (leave blank to keep current): " new_title
        read -p "Enter new description (leave blank to keep current): " new_description
    
        # Update title if new_title is provided
        if [[ -n "$new_title" ]]; then
          sed -i "s/title: \"New Remix App\"/title: \"$new_title\"/" "$app_file"
          echo "Title updated to: $new_title"
        else
          echo "Title left unchanged."
        fi
    
        # Update description if new_description is provided
        if [[ -n "$new_description" ]]; then
          sed -i "s/content: \"Welcome to Remix!\"/content: \"$new_description\"/" "$app_file"
          echo "Description updated to: $new_description"
        else
          echo "Description left unchanged."
        fi
      else
        echo "Meta information left unchanged in $app_file."
      fi
    fi
    

  else
    echo "File not found: $app_file"
  fi
}
