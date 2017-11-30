#CONSTANTS

PLAYER_SYM = 'X'.freeze
COMPUTER_SYM = 'O'.freeze
WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze 


#DISPLAY

def prompt(string)
  puts "  ▕  ▩▕  ▬▬▬▶   » #{string} «"
end

def display_board(brd)
  system("clear")
  puts "════════════════════════════════════════════".center(80)
  puts "  ══╦══ ╔══     ══╦══    ╔══    ══╦══   ╔═   ".center(80)
  puts "    ║ ▫ ║         ║ ╔══╗ ║        ║ ╔═╗ ╠═    ".center(80)
  puts "    ║ ║ ╚══       ║ ╚══║ ╚══      ║ ╚═╝ ╚═   ".center(80)
  puts "════════════════════════════════════════════".center(80)
  puts "".center(80)
  puts "".center(80)
  puts "".center(80)
  puts "".center(80)
  puts "╔═══════╦═══════╦═══════╗".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "║   #{brd[1]}   ║   #{brd[2]}   ║   #{brd[3]}   ║".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "╠═══════╬═══════╬═══════╣".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "║   #{brd[4]}   ║   #{brd[5]}   ║   #{brd[6]}   ║".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "╠═══════╬═══════╬═══════╣".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "║   #{brd[7]}   ║   #{brd[8]}   ║   #{brd[9]}   ║".center(80)
  puts "║       ║       ║       ║".center(80)
  puts "╚═══════╩═══════╩═══════╝".center(80)
  puts "".center(80)
  puts "".center(80)
  puts "".center(80)
end

def display_valid_choice(brd)
  hash = valid_choice(brd)
  if hash.keys.size == 1
    hash.keys.join(' ')
  elsif hash.keys.size > 1
    hash.keys.insert(-2, 'or').join(' ')
  else
    'NO CHOICE LEFT'
  end
end

def over_message(brd)
  if cpu_winner?(brd)
    "You lose!"
  elsif player_winner?(brd)
    "You win!"
  else
    "It's a draw!"
  end
end




#CONDITIONS

def game_over?(brd)
  if cpu_winner?(brd)
    true 
  elsif player_winner?(brd)
    true
  elsif valid_choice(brd).empty? 
    true
  else
    false
  end 
end


def cpu_winner?(brd)
  cpu_board_state = brd.select do |_, v|
    v == COMPUTER_SYM
  end
  WIN.include?(cpu_board_state.keys) ? true : false
end
      
def player_winner?(brd)
  player_board_state = brd.select do |_, v|
    v == PLAYER_SYM
  end
  WIN.include?(player_board_state.keys) ? true : false
end

def player_first?
  prompt("Do you want to go first? (Y/N)")
  first = gets.chomp
  if first.casecmp?('y')
    true
  else 
    false
  end
end


#LOGIC

def player_turn!(brd)
  prompt('Time to make your move.')
  player_choice = ' ' 
   loop do
      prompt("Choose #{display_valid_choice(brd)}")
      player_choice = gets.chomp.to_i
    break if valid_choice(brd).keys.include?(player_choice)
      prompt('Invalid choice. Try again.')
    end 
    
   brd[player_choice] = PLAYER_SYM
   display_board(brd)
end


def cpu_turn!(brd)
  prompt("Computer's turn.")
  brd[valid_choice(brd).keys.sample] = COMPUTER_SYM
  
  display_board(brd)
end

def player_first_loop(brd)
  loop do
  break if game_over?(brd)
    player_turn!(brd)
  break if game_over?(brd)
    cpu_turn!(brd)
  break if game_over?(brd)
  end
end

def cpu_first_loop(brd)
  loop do
  break if game_over?(brd)
    cpu_turn!(brd)
  break if game_over?(brd)
    player_turn!(brd)
  break if game_over?(brd)
  end
end

#INITIALIZATION

def initialize_board
  hash = Hash.new(' ')
  (1..9).each { |i| hash[i] = ' ' }
  hash
end

def valid_choice(brd)
  brd.select do |k, _|
    brd[k] == ' '
  end
end


#FLOW

loop do
  board_state = initialize_board
  display_board(board_state)
  
  #choose difficulty
 
  prompt("You have the #{PLAYER_SYM} and computer the #{COMPUTER_SYM}.")
  puts ''

  if player_first?
    prompt("Player plays first.") 
    player_first_loop(board_state)
  else
    prompt("Computer plays first.")
    cpu_first_loop(board_state)
  end
  
  prompt("#{over_message(board_state)}")
  prompt('Do you want to play again? (Y/N)')
  again = gets.chomp
  again.casecmp?('n') ? prompt("Goodbye!") : false
  break if again.casecmp?('n')
 
end









