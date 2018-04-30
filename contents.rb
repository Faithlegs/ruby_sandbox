contents_array = [[1,"Enter Sunset",           4],
				  [2,"A Wind from the East",  38],
				  [3,"Nothing Seen",          67],
				  [4,"Paths Well Trodden",   101],
				  [5,"Painful Truth",        130],
				  [6,"Deepest Green",        169],
				  [7,"An Old Friend",        204],
				  [8,"A Wind from the West", 248],
				  [9,"A Willow Wept",        290]]
line_width = 51
puts 
contents_array.each do |entry|
	puts "Chapter #{entry[0]}".ljust(line_width/3) + 
	     entry[1].center(line_width/2) + 
	     "p#{entry[2]}".rjust(line_width/3)
end
