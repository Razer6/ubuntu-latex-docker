FROM ubuntu:18.04

LABEL maintainer Mario Werner <mario.werner@iaik.tugraz.at>

# Install commonly used packages for working with latex.
# * graphviz + inkscape + ipe + libreoffice for converting figures
# * make + latexmk for convenient building
# * texlive-extra-utils (pdfcrop) + latexdiff for post processing
# * python3 + python3-pip for scripting (e.g., bibliography post processing)
# * python-pygments for syntax highlighting with minted
# * texlive-full (without documentation packages) for latex
#
# Additionally, draw.io gets installed into the image. Note that the
# `--no-sandbox` argument is needed for running drawio as root.
#
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    biber \
    graphviz \
    inkscape \
    ipe \
    latexdiff \
    latexmk \
    libreoffice \
    make \
    python-pygments \
    python3 \
    python3-pip \
    `apt-cache depends texlive-full | grep "Depends:" | grep -v "\-doc" | sed "s/  Depends: //g" | xargs` \
  && pip3 install wavedrom \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    libasound2 \
    libx11-xcb1 \
  && curl -LO https://github.com/jgraph/drawio-desktop/releases/download/v12.2.2/draw.io-amd64-12.2.2.deb \
  && apt install ./draw.io-amd64-12.2.2.deb -y --no-install-recommends \
  && rm draw.io-amd64-12.2.2.deb \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
