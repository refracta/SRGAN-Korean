$pdflatex = If ($args.Length -Eq 0) {"pdflatex"} Else {$args[0]}
$currentPath = pwd
function Run-Build($OutputDirectory, $JobName, $TeXFile, $FinalName){
    iex $($pdflatex + " -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=$OutputDirectory -aux-directory=auxil -jobname=`"$JobName`" $TeXFile")
    cd $OutputDirectory
    mv "$JobName.pdf" "$FinalName.pdf" -Force
    cd $currentPath
}

(Get-Content -Path SRGANpaper_CVPR_Arxiv.tex -Raw) -Replace "\\newcommand\{\\summary\}\[1\]\{\}", "\newcommand{\summary}[1]{{\color{blue}\textit{요약: #1}}}" > SRGANpaper_CVPR_Arxiv-Korean-Summary.tex
(Get-Content -Path SRGANpaper_CVPR_Arxiv.tex -Raw) -Replace "\\newcommand\{\\eng\}\[1\]\{\}", "\newcommand{\eng}[1]{`n`n#1`n`n}" > SRGANpaper_CVPR_Arxiv-EngKor.tex
(Get-Content -Path SRGANpaper_CVPR_Arxiv-Korean-Summary.tex -Raw) -Replace "\\newcommand\{\\eng\}\[1\]\{\}", "\newcommand{\eng}[1]{`n`n#1`n`n}" > SRGANpaper_CVPR_Arxiv-EngKor-Summary.tex

Run-Build out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv SRGAN-Korean
Run-Build out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-Korean-Summary SRGAN-Korean-Summary
Run-Build out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-EngKor SRGAN-EngKor
Run-Build out SRGANpaper_CVPR_Arxiv SRGANpaper_CVPR_Arxiv-EngKor-Summary.tex SRGAN-EngKor-Summary
