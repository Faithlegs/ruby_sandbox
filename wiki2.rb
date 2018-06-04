#TODO:
# =>*Fix mismatch between paragraphs and links (remove empty paras at the
# =>  @paragraph level, rather than the raw_text level?)
# =>*Implement disambiguations.
# =>*Work out how to run direct from command line, and concatenate args.

require 'rubygems'
require 'nokogiri'
require 'open-uri'

@article_url,@output_text, 
@link_array, @wiki_page, @paragraphs = nil
@current_p = 0

def get_title
  command_args = ARGV
  if command_args.length > 0
  	title = command_args[0].split('_').each{|x| x.capitalize!}.join('_')#.capitalize
  else
  	puts "Enter the page you would like to view:"
  	title = STDIN.gets.chomp
  	title = title.split(' ')
  	title = title.each{ |x| x.capitalize! }.join('_')
  end
  title
end

def get_wiki_page
  @wiki_page = Nokogiri::HTML(open(@article_url))
end

def print_url
  text = @article_url
  w = `stty size`.split.last.to_i
	puts ' '
	puts ('-'*text.length).center(w)
	puts text.center(w)
	puts ('-'*text.length).center(w)
	puts ' '	
end

def change_article(title)
  @article_url = title_to_url(title)
  @wiki_page = get_wiki_page
  #check if valid wiki page?
  #disambig? else:
  @output_text = strip_text
  @link_array = set_link_array
  @current_p = 0
end

def title_to_url(title)
  "https://en.wikipedia.org/wiki/" + title.to_s
end

def strip_text
  #parse the web page
  @paragraphs = @wiki_page.xpath("//p")
  raw_text = @paragraphs.map { |x| x.to_s.gsub(/\<[^\>]+\>/,'') }
  raw_text.map! { |x| x.gsub(/\[[^\]]+\]/,'') } 
  raw_text = raw_text.reject { |c| c.empty? }
end

def set_link_array
  link_array = @paragraphs.map { |paragraph| paragraph.css('a') }
  link_array.map { |links| 
	  links.map { |link|
		  link['href'].gsub(/\/wiki\//,'')
	  }.reject { |link| /\#cite/.match(link)}
  }
end


def display_links
	puts ''
	link_array = Marshal.load( Marshal.dump(@link_array[@current_p]))
	link_array.map!.with_index { |link, i|
		"#{i + 1}. #{URI.decode(link.split('_').join(' '))}"
	}
	link_array << ' ' if link_array.length % 2 == 1 
	
	w = `stty size`.split.last.to_i
	center = link_array.length / 2
	x = 0
	
	while x < center
		spacing = (w / 2) - link_array[x].length
		puts link_array[x] + ' ' * spacing + link_array[x+center]
		x += 1
	end
	puts ' '
end

def select_link(number)
  link_array = @link_array[@current_p]
  title = link_array[number-1]
  change_article(title)
end

def disambigufy
  puts "DID THAT HELP?"
  #TODO:
    #*Parse and output disambig page
    #*Take input and change_article
end

def next_paragraph
  if @current_p >= @output_text.length
    puts "End of Article."
    puts ''
  else
    @current_p += 1
  end
end

def prev_paragraph
  @current_p -= 1 unless @current_p <= 0
end

def display_paragraph
  puts @output_text[@current_p]
end

def begin_article
  print_url
  display_paragraph
end

def initialise
  title = get_title
  change_article(title)
  begin_article
end

def print_help
  puts "THIS IS THE HELP MENU"
  puts "URL: #{@article_url}"
  puts "current_p: #{@current_p}"
end

#MAIN BODY OF PROGRAM
initialise
loop do
  input = STDIN.gets.chomp.downcase
  if input.to_i.to_s == input
    select_link(input.to_i)
    begin_article
  else
    case input
    when 'links', 'link', 'l'
      display_links
    when "disambiguation", 'disambig', 'dis'
      disambigufy
    when '' #check this
      next_paragraph #add in an if statement here?
      display_paragraph
    when 'back', 'b'
      prev_paragraph #add in an if statement here?
      display_paragraph
    when 'change'
      initialise
    when 'exit'
      exit
    when 'h', 'help'
      print_help
    else
      puts "Invalid input. Try again or enter -h for options."
    end
  end
end

#main flow
  #initialise?
    #get_title
    #change_article(title)
  #begin_article
  #start loop:
    #get input
      #links => display_links
      #integer => select_link
        #begin_article
      #disambig = disambigufy
        #get input => change_article
          #begin_article
      #change => change_article
        #begin_article
      #navigate 
        #next/prev_paragraph
        #display_paragraph
      #exit
