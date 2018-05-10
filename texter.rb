

def converter(text)
	@l = 4
	@h = 5
	@t = text

	asciiText = [" #  ##   ## ##  ### ###  ## # # ###  ## # # #   # # ###  #  ##   #  ##   ## ### # # # # # # # # # # ### ###  #          ",
				 "# # # # #   # # #   #   #   # #  #    # # # #   ### # # # # # # # # # # #    #  # # # # # # # # # #   #   #  #          ",
				 "### ##  #   # # ##  ##  # # ###  #    # ##  #   ### # # # # ##  # # ##   #   #  # # # # ###  #   #   #   ##  #          ",
				 "# # # # #   # # #   #   # # # #  #  # # # # #   # # # # # # #    ## # #   #  #  # # # # ### # #  #  #                   ",
				 "# # ##   ## ##  ### #    ## # # ###  #  # # ### # # # #  #  #     # # # ##   #  ###  #  # # # #  #  ###  #   #   #      "]

	alphameric = [('A'..'Z').to_a,(0..25).to_a].transpose.to_h
	alphameric['?'] = 26
	alphameric['!'] = 27
	alphameric['.'] = 28
	alphameric[' '] = 29
	alphameric.default = 26

	text_array = @t.upcase.split('')
	text_indexes = text_array.map{|x| alphameric[x]}

	dots = '.'*@l
	dotsR = Regexp.new dots

	row_number = 0
	letter_array = Array.new

	@h.times do
	    row = asciiText[row_number]
	    #letter_array[row_number] = row.scan(/..../)
	    letter_array[row_number] = row.scan(dotsR)
	    row_number += 1
	end
	    
	letter_array = letter_array.transpose

	outputRowNumber = 0
	puts '-'*text.length*@h
	@h.times do
	    output_row_string = ''
	    text_indexes.each{|x| output_row_string += letter_array[x][outputRowNumber] + ' '}
	    puts output_row_string
	    outputRowNumber +=1
	end
	puts '-'*text.length*@h
end

running = true
while running
	puts 'Please input some text: '
	input = gets.chomp
	exit if input.downcase == 'exit'
	converter(input)
end