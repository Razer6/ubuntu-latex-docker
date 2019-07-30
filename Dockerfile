FROM ubuntu:18.04

LABEL maintainer Mario Werner <mario.werner@iaik.tugraz.at>

# Install commonly used packages for working with latex.
# * inkscape + ipe + libreoffice for converting figures
# * make + latexmk for convenient building
# * texlive-extra-utils (pdfcrop) + latexdiff for post processing
# * python3 + python3-pip for scripting (e.g., bibliography post processing)
# * python-pygments for syntax highlighting with minted
# * texlive-full (without documentation packages) for latex
#
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    biber \
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
  && apt-get clean && rm -rf /var/lib/apt/lists/*
