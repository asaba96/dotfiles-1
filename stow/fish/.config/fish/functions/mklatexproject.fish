function mklatexproject
	mkdir $argv[1]
cd $argv[1]
cp ~/Developer/latex-homework-template/*.sty .
cp ~/Developer/latex-homework-template/main.tex .
cd ..
end
