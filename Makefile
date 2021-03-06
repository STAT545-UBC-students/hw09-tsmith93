all: report.html

clean:
	rm -f deniro.csv deniro.tsv deniro.png report.html
	
report.html: report.rmd deniro.tsv deniro.png
	Rscript -e 'rmarkdown::render("$<")'
	
deniro.png: deniro.tsv
	Rscript -e 'library(ggplot2); library(tidyverse); data=read.delim("$<") %>% ggplot(aes(Year, Score)) + geom_point() + geom_smooth(se = FALSE); ggsave("$@")'

deniro.tsv: deniro.rt.r deniro.csv
	Rscript $<
	
deniro.csv:
	Rscript -e 'download.file("https://people.sc.fsu.edu/~jburkardt/data/csv/deniro.csv", destfile = "deniro.csv", quiet = TRUE)'
