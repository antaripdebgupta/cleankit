#!/bin/bash

# Source the framework-specific scripts
source /usr/local/share/cleankit/reactjsClean.sh
source /usr/local/share/cleankit/nextjsClean.sh
source /usr/local/share/cleankit/remixClean.sh


echo "Boilerplate Cleaner"

# Check source path
while true; do
    read -p "Enter the path to your project (default: .): " project_path

     if [[ -z "$project_path" ]]; then
        echo "❌ Please enter a valid path."
        continue
    fi
    
    project_path=${project_path:-.}

    if [[ ! -d "$project_path" ]]; then
        echo "❌ Invalid path: '$project_path' does not exist."
        continue
    fi

    break
done

# Detect the framework
detect_framework() {
    if [[ -f "$1/package.json" ]]; then
      if grep -q '"next"' "$1/package.json"; then
        echo "nextjs"
      elif grep -q '"@remix-run/node"' "$1/package.json"; then
        echo "remix"
      elif grep -q '"react"' "$1/package.json"; then
        echo "react"
      else
        echo "unknown"
      fi
    else
        echo "unknown"
    fi
}

framework=$(detect_framework "$project_path")

if [[ "$framework" == "unknown" ]]; then
    echo "❌ Unable to detect the framework. Ensure the project has a valid package.json file."
    exit 1
fi

echo "Detected framework: $framework"

case $framework in
  react)
    echo "Are you sure you want to remove boilerplate files? (y/n)"
    read -p "Confirm: " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
      remove_react_files "$project_path"
      clean_react_file "$project_path"
      echo "React cleanup complete!"
      update_meta_info "$project_path"
    else
      echo "Operation cancelled."
    fi
    ;;
  nextjs)
    echo "Are you sure you want to remove boilerplate files? (y/n)"
    read -p "Confirm: " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
      remove_nextjs_files "$project_path"
      clean_nextjs_file "$project_path"
      echo "Next.js cleanup complete!"
      update_nextjs_meta_info "$project_path"
    else
      echo "Operation cancelled."
    fi
    ;;
  remix)
    echo "Are you sure you want to remove boilerplate files? (y/n)"
    read -p "Confirm: " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
      remove_remix_files "$project_path"
      clean_remix_file "$project_path"
      echo "Remix cleanup complete!"
    else
      echo "Operation cancelled."
    fi
    ;;
  *)
    echo "Unsupported framework."
    exit 1
    ;;
esac

# Run the project automatically if the user confirms
run_project() {
    case $framework in
      react)
        echo "Starting React project..."
        (cd "$project_path" && npm start)
        ;;
      nextjs)
        echo "Starting Next.js project..."
        (cd "$project_path" && npm run dev)
        ;;
      remix)
        echo "Starting Remix project..."
        (cd "$project_path" && npm run dev)
        ;;
    esac
}

echo "Do you want to run the project now? (y/n)"
read -p "Confirm: " run_confirm

if [[ "$run_confirm" == "y" || "$run_confirm" == "Y" ]]; then
    echo "Running the project..."
    run_project
    exec bash # Automatically opens a new prompt for the next user input
else
    echo "You chose not to run the project. Exiting."
fi