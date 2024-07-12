#!/bin/bash

apt update && apt install -y rsync pandoc
# pip install -U pip
# pip install -U jupyterlab
# pip install "nbconvert<6" jupyter_contrib_nbextensions
# pip install -U "nbconvert<6" jupyter_contrib_nbextensions jinja2
# pip install -U nbconvert jupyter_contrib_nbextensions notebook jupyter
# pip install -U nbconvert jupyter_contrib_nbextensions jinja2
# sudo -E pip install -U nbconvert jupyter_contrib_nbextensions
# pip install -U nbconvert https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
pip install -U nbconvert # jupyterlab
# pip install jupyter_contrib_nbextensions "nbconvert==6.4.4" "jinja2==3.0.3"
echo "+++----------------------------------+++"
python -V
pip -V
# jupyter nbconvert --help
# jupyter contrib nbextension install --user
echo "----------------------------------"
# jupyter nbextension install --user
# jupyter contrib nbextension install --user
# jupyter nbextension enable codefolding/main
# # nbconvert templates: https://stackoverflow.com/a/24067557/9058671
# jupyter nbconvert --to html --embed-images **/*.ipynb
# jupyter nbconvert --to html **/*.ipynb
# jupyter nbconvert --to html_ch --EmbedImagesPreprocessor.embed_remote_images=True **/*.ipynb # https://stackoverflow.com/a/69522338/9058671
jupyter nbconvert --to html --EmbedImagesPreprocessor.embed_remote_images=True **/*.ipynb
