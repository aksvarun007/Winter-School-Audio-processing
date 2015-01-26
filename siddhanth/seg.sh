#! /bin/bash


for filename in *.wav;
do
#echo $filename
a=0
leng=`ffprobe -i $filename -show_format -v quiet | sed -n 's/duration=//p'`
n=${leng%.*}
	while [ $a -lt $n ]
	do      
                var1=00:00:0$a
		echo $var1
		ffmpeg -ss $var1 -i $filename -t 2 -c:v copy -c:a copy $filename$a".wav";
		((a+=2))
	done
done
		 
