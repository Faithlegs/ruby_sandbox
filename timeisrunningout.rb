@row0 = @row1 = @row2 = @row3 = @row4 = @row5 = ''

@row0 = '_'*32
@row5 = "|#{'_'*30}|"









def time_diff_milli(start, finish)
	(finish-start)*1000.0
end

def showDisplay
	displayArray = []
	displayArray[0] = "|#{' '*((30-@row1.length)/2)}#{@row1}#{' '*((30-@row1.length)/2)}|"
	displayArray[1] = "|#{' '*((30-@row2.length)/2)}#{@row2}#{' '*((30-@row2.length)/2)}|"
	displayArray[2] = "|#{' '*((30-@row3.length)/2)}#{@row3}#{' '*((30-@row3.length)/2)}|"
	displayArray[3] = "|#{' '*((30-@row4.length)/2)}#{@row4}#{' '*((30-@row4.length)/2)}|"
	puts '_'*32
	puts displayArray
	puts '|' + '_'*30 + '|'
end

t1=Time.now
while true 
	t2 = Time.now
	if time_diff_milli(t1,t2) > 1000
		@row1 = "#{'%02d' % t2.hour}:#{'%02d' % t2.min}:#{'%02d' % t2.sec}"
		@row3 = "Time is running out!"
		t1 = t2
		showDisplay
	end
end




