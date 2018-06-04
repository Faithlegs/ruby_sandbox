#TODO: *Fix disambiguation pages (show links)
#      *Allow navigation through wikipedia links.

require 'rubygems'
require 'nokogiri'
require 'open-uri'

TESTMODEACTIVE = ARGV.last.downcase == "testmode" if ARGV.length > 0

command_args = ARGV

if command_args.length > 0
	page_name = command_args[0].split('_').each{|x| x.capitalize!}.join('_')#.capitalize
else
	puts "Enter the page you would like to view:"
	page_name = STDIN.gets.chomp.split('_').each{|x| x.capitalize! }.join('_')
	page_name = page_name.split(' ').each{|x| x.capitalize! }.join('_')
end

def print_title(text)
	w = `stty size`.split.last.to_i
	puts ' '
	puts ('-'*text.length).center(w)
	puts text.center(w)
	puts ('-'*text.length).center(w)
	puts ' '	
end

wiki_url = "https://en.wikipedia.org/wiki/" + page_name.to_s 

print_title(wiki_url)

wiki_page = Nokogiri::HTML(open(wiki_url))
if !wiki_page
	puts "No page found."
	exit
end


paragraphs = wiki_page.xpath("//p")
raw_text = paragraphs.map { |x| x.to_s.gsub(/\<[^\>]+\>/,'') }
raw_text.map! { |x| x.gsub(/\[[^\]]+\]/,'') } 
raw_text = raw_text.reject { |c| c.empty? }
#link_array = paragraphs.xpath("//link:a", 'link' => /\/wiki\/.+/) #DO LATER

link_array = paragraphs.map { |paragraph| paragraph.css('a') }
link_array.map! { |links| 
	links.map { |link|
		link['href'].gsub(/\/wiki\//,'')
	}.reject { |link| /\#cite/.match(link)}
}

def display_links(link_array, current_paragraph)
	w = `stty size`.split.last.to_i
	puts ''
	link_array = link_array[current_paragraph]
	link_array.map!.with_index { |link, i|
		"#{i+1}. #{URI.decode(link.split('_').join(' '))}"
	}
	link_array << ' ' if link_array.length % 2 == 1 
	
	center = link_array.length / 2
	x = 0
	
	while x < center
		spacing = (w / 2) - link_array[x].length
		puts link_array[x] + ' ' * spacing + link_array[x+center]
		x += 1
	end
	puts ' '
end

def navigate_to_link(para_number, link_number)
	if link_number - 1 < 0 || link_number  > link_array[para_number].length
		return nil
	else
	page_name = "https://en.wikipedia.org/wiki/" + 
		link_array[para_number][link_number - 1]#change url to link url
	end
	puts page_name
end
	


if TESTMODEACTIVE
	puts "BEGIN TEST MODE"
	puts link_array
	puts "END TEST MODE"
end
#=begin
p_number = 0
paragraph_loop = true
puts raw_text[p_number]
while paragraph_loop do 
	
	puts ' '
	input = STDIN.gets.chomp.downcase
	if input.to_i.to_s == input #check if input is an integer value
		navigate_to_link(p_number, input.to_i)
		break
	end
	case input
	when 'back', 'b', 'up' then p_number -= 1
	when 'exit', 'end' then exit
	when 'disambiguation','disambig', 'disamb', 'dis'
		page_name = page_name + '_(disambiguation)'
		paragraph_loop = false
	when 'links', 'link', 'l' then display_links(link_array, p_number)
	else 
		p_number += 1
		if p_number > raw_text.length
			puts 'End of Article.'
			exit
		end
		puts raw_text[p_number]
	end

	
end




