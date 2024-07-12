#!/bin/bash

# Update pandoc

# apt update && apt install -y pandoc
# gh release -R jgm/pandoc download latest -p "*amd64*.deb" # Not working with nektos/act
URL=$(curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
    | jq -r '.assets[] | select(.name | test(".*amd64.*\\.deb")) | .browser_download_url')
    # | wget -qi -
wget -qP /tmp/ "$URL"
dpkg -i /tmp/$(basename "$URL")
# pandoc -v

# Templates

# curl -O http://b.enjam.info/panam/styling.css # --css=styling.css

git clone --depth 1 https://github.com/jez/pandoc-markdown-css-theme
mkdir pandoc-theme-jez
mv pandoc-markdown-css-theme/{template.html5,public/css/*.css} pandoc-theme-jez/
rm -rf pandoc-markdown-css-theme

# git clone --depth 1 https://github.com/ryangrose/easy-pandoc-templates
# mv easy-pandoc-templates/html pandoc-theme-ryangrose
# rm -rf easy-pandoc-templates

# git clone --depth 1 https://github.com/tajmone/pandoc-goodies
# mv pandoc-goodies/templates/html5/github/GitHub.html5 .
# rm -rf pandoc-goodies

# git clone --depth 1 https://github.com/dracula/pandoc

# Convert

# pagesRoot="/${klezm/QuantumAnnealingPlayground#"klezm/"}"
# pagesRoot="/${$GITHUB_REPOSITORY#"$GITHUB_REPOSITORY_OWNER/"}"
# pagesRoot="/$(echo "$GITHUB_REPOSITORY" | sed -e s/^$GITHUB_REPOSITORY_OWNER\\///)"
# pagesRoot="$(realpath "$(echo "$GITHUB_REPOSITORY" | grep -Po "^$GITHUB_REPOSITORY_OWNER\/\K.*")")/"
pagesRoot="$(pwd)"
# | Could not find data file /usr/share/pandoc/data/templates/template.html5
echo "~~~~~ pagesRoot: $pagesRoot"
echo ">$GITHUB_REPOSITORY< --- >$GITHUB_REPOSITORY_OWNER<"

pandocOptions=(
    "--from=markdown+emoji+tex_math_dollars"
    # "--from=markdown"
    "--to=html5+smart"
    # "--to=html"
    "--standalone"
    "--toc"
    "--toc-depth=5"
    "--number-sections"
    "--shift-heading-level-by=-1"
    "--mathjax"
    # "--mathjax=https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.min.js"
    # "--mathjax=https://cdn.jsdelivr.net/npm/mathjax-full@3/es5/tex-mml-svg.min.js"
    # "--wrap=none"
    # "--filter pandoc-sidenote"
    "--data-dir=$pagesRoot"
    # "--template=pandoc-theme-ryangrose/bootstrap_menu.html"
    # "--template=pandoc-theme-ryangrose/clean_menu.html"
    # "--template=pandoc-theme-ryangrose/easy_template.html"
    # "--template=pandoc-theme-ryangrose/elegant_bootstrap_menu.html"
    # "--template=pandoc-theme-ryangrose/uikit.html"
    # "--template=pandoc-theme-jez/template.html5"
    # "--css=pandoc-theme-jez/theme.css"
    # "--css=pandoc-theme-jez/skylighting-solarized-theme.css"
    # "--css=styling.css"
)

ls -lha
echo " >>> pandocOptions: ${pandocOptions[@]}"

for f in $(find . -iname "README.md"); do
    if [[ "$(dirname "$f")" != "." ]]; then
        echo ">>> $f ::: $(dirname "$f")"
        # relDir="$(echo "$(dirname "$f")/" | tr -cd '/' | sed 's/$/../g')"
        relDir="$(echo "$(dirname "$(dirname "$f")")/" | tr -cd '/' | sed 's/\//..\//g')"
    else
        relDir=""
    fi
    echo "$(dirname "$f")/index.html" "$f" "relDir: $relDir"
    pandocOptions+=(
        # "--template=${relDir}pandoc-theme-ryangrose/bootstrap_menu.html"
        # "--template=${relDir}pandoc-theme-ryangrose/clean_menu.html"
        # "--template=${relDir}pandoc-theme-ryangrose/easy_template.html"
        # "--template=${relDir}pandoc-theme-ryangrose/elegant_bootstrap_menu.html"
        # "--template=${relDir}pandoc-theme-ryangrose/uikit.html"
        "--template=${relDir}pandoc-theme-jez/template.html5"
        "--css=${relDir}pandoc-theme-jez/theme.css"
        # "--css=${relDir}pandoc-theme-jez/skylighting-solarized-theme.css"
        # "--css=${relDir}styling.css"
    )
    echo " >>> pandocOptions: ${pandocOptions[@]}"
    cd "$(dirname "$f")"
    pandoc "${pandocOptions[@]}" --output index.html $(basename "$f")
    cd -
    # pandoc "${pandocOptions[@]}" --output "$(dirname "$f")/index.html" "$f"
    rm "$f"
done
# find . -iname "README.md" | xargs -I {} -t sh -c 'pandoc "$pandocOptions" --output "$(dirname "{}")/index.html" {}'
# find . -iname "README.md" -execdir pandoc "${pandocOptions[@]}" --output index.html {} \;
# find . -iname "README.md" -delete


# Fix mathjax import (add async attribute)
# https://unix.stackexchange.com/questions/26284/how-can-i-use-sed-to-replace-a-multi-line-string
# find . -iname "index.html" -exec perl -0777 -pi -e "s/<script([^>]*?src=['\"][^'\"]*mathjax[^'\"]*['\"][^>]*>(\s|.)*?<\/script>)/<script async \1/gm;t" {} \;
