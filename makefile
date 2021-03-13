.SECONDEXPANSION:

default: $(subst .txt,.mp4,$(shell ls *.txt))

%.mp4: %.mp3 %.jpg
	ffmpeg -y -loop 1 -i $*.jpg -i $< -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest $@

%.jpg: %.txt
	wget -O $@ $(shell head -n 1 $<)

%.mp3: %.list
	ffmpeg -y -f concat -safe 0 -i $< -c copy $@

%.list: %.txt $$(addsuffix .mp3,$$(shell tail -n +2 $$*.txt))
	echo $^
	tail -n +2 $< | sed "s/.*/file '&.mp3'/g" | tee $@

%.webm:
	youtube-dl --format 251 --output $@ $*

%.mp3: %.webm
	ffmpeg -y -i $< -q:a 0 -map a $@
