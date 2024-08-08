#! /bin/bash

read -p "Enter a project name: " PROJECT_NAME

# create directory structure
mkdir -p \
    dce \
    src/{csv,img,output,partials,tmp,xlsx}

# Initialize git
echo "Initializing git ..."

if [ -d .git/ ]
then
    echo "Removing existing git files."
    rm -rf .git/
fi

git init -b main
git add .
git commit -m "First commit"

# Add .gitkeep
for dir in $(ls -A src/.)
do
    touch src/${dir}/.gitkeep
done

# Create default file
cat <<-EOF > default.yaml
    toc: true
    toc-depth: 3
    standalone: true
    pdf-engine: lualatex
    # reference-doc: artialys-references.docx
    number-sections: true

    reader: markdown

    # draft
    writer: pdf
    output-file: \${.}/output/${PROJECT_NAME}.pdf

    # share
    # writer: docx
    # output-file: \${.}/output/memoire_technique_${PROJECT_NAME}.docx

    input-files:
    - \${.}/partials/heads.md
    - \${.}/partials/00-introduction.md
    - \${.}/partials/99-appendix.md

    variables:
    geometry:
        - margin=1in
EOF

# Create file
echo "\newpage{}" > src/partials/heads.md
echo -e "# Introduction" > src/partials/00-introduction.md
echo -e "# Annexes" > src/partials/99-appendix.md

# Clean up
rm -rf init.sh LICENSE README.md
