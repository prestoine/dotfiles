#!/bin/bash

cd ~/coding/projects

echo "Select a project to work on:"
echo ""

# List all directories in projects folder
select project in */ "Notes only" "Just terminal"; do
    case $project in
        "Notes only")
            echo "Opening notes..."
            cd ~/coding/notes
            nvim .
            break
            ;;
        "Just terminal")
            echo "Opening terminal in projects directory..."
            break
            ;;
        "")
            echo "Invalid selection. Please try again."
            ;;
        *)
            if [[ -n $project ]]; then
                cd "$project"
                echo "Opening $project in Neovim..."
                nvim .
                break
            fi
            ;;
    esac
done
