#!/bin/bash

cp SRGANpaper_CVPR_Arxiv.tex SRGANpaper_CVPR_Arxiv-Korean-Summary.tex
sed -i 's/\\newcommand{\\summary}\[1\]{}/\\newcommand{\summary}[1]{{\\color{blue}\\textit{요약: #1}}}/g' SRGANpaper_CVPR_Arxiv-Korean-Summary.tex
cp SRGANpaper_CVPR_Arxiv.tex SRGANpaper_CVPR_Arxiv-EngKor.tex
sed -i 's/\\newcommand{\\eng\}\[1\]{}/\\newcommand{\eng}[1]{\n\n#1\n\n}/g' SRGANpaper_CVPR_Arxiv-EngKor.tex
cp SRGANpaper_CVPR_Arxiv-Korean-Summary.tex SRGANpaper_CVPR_Arxiv-EngKor-Summary.tex
sed -i 's/\\newcommand{\\eng\}\[1\]{}/\\newcommand{\eng}[1]{\n\n#1\n\n}/g' SRGANpaper_CVPR_Arxiv-EngKor-Summary.tex

runBuild(){
    local outputDirectory=${1}
    local jobname=${2}
    local texFile=${3}
    local finalName=${4}
    local currentPath=$(pwd)
    docker run -ti \
      -v miktex:/miktex/.miktex \
      -v `pwd`:/miktex/work \
      miktex/miktex \
      pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=$outputDirectory -aux-directory=auxil -jobname=$jobname $texFile
    cd $outputDirectory
    mv $jobname.pdf $finalName.pdf
    cd $currentPath
}

runBuild out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv SRGAN-Korean
runBuild out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-Korean-Summary SRGAN-Korean-Summary
runBuild out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-EngKor SRGAN-EngKor
runBuild out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-EngKor-Summary.tex SRGAN-EngKor-Summary