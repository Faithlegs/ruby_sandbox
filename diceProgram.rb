class Die

  def initialize
    # I'll just roll the die, though we
    # could do something else if we wanted
    # to, like setting the die with 6 showing.
    roll
  end

  def roll
    @numberShowing = 1 + rand(6)
  end

  def showing
    @numberShowing
  end

  def cheat number
    if number <= 6 && number >= 1
      @numberShowing = number
    else
      puts "Dice can only show the numbers 1 to 6."
    end
  end


end

testDie = Die.new
puts testDie.showing
testDie.cheat 6
puts testDie.showing
testDie.cheat 3
puts testDie.showing
testDie.cheat 8
puts testDie.showing
