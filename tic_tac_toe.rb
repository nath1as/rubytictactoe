# coding: utf-8
require 'pry'

# CONSTANTS

PLAYER_SYM = 'X'.freeze
COMPUTER_SYM = 'O'.freeze
WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

# DISPLAY

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
  elsif draw(brd)
    "It's a draw!"
  else 
    "ERROR MESSAGE"
  end
end


def game_winner(scr)
  if scr[:cpu] == 5
    prompt("CPU wins THE GAME")
  elsif scr[:player] == 5
    prompt("PLAYER wins THE GAME")
  else
    prompt("The game continues.")
  end
end

# CONDITIONS

def game_over?(brd)
  if cpu_winner?(brd)
    true
  elsif player_winner?(brd)
    true
  elsif draw(brd)
    true
  else
    false
  end
end


def cpu_winner?(brd)
  cpu_board_state = brd.select do |_, v|
    v == COMPUTER_SYM
  end
  cwin = false
  carrays = cpu_board_state.keys.permutation(3).to_a
  (WIN & carrays).size >=1 ? true : false
end

def player_winner?(brd)
  player_board_state = brd.select do |_, v|
    v == PLAYER_SYM
  end
  pwin =  false
  parrays = player_board_state.keys.permutation(3).to_a
  (WIN & parrays).size >=1 ? true : false
end


def find_at_risk_square(line, brd)
  if brd.values_at(*line).count('X') == 2
    brd.select{ |k,v| line.include?(k) && v == ' ' }.keys.first
  else
    nil
  end
end

def cpu_turn!(brd)
  square = nil
  WIN.each do |line|
    square = find_at_risk_square(line, brd)
    break if square
  end

  if !square
    square = valid_choice(brd).keys.sample
  end

  brd[square] = COMPUTER_SYM
  display_board(brd)
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

def draw(brd)
  (valid_choice(brd).empty? && !player_winner?(brd) && !cpu_winner?(brd)) ? true : false
end


# LOGIC




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


#def cpu_turn!(brd)
#  prompt("Computer's turn.")
#  if difficulty == 'EASY'
#    brd[valid_choice(brd).keys.sample] = COMPUTER_SYM
#  elsif difficulty == 'MEDIUM'
#ADD
#  elsif difficulty == 'IMPOSSIBLE'
#ADD
#  end
#
#  display_board(brd)
#end

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

def score(brd, scr)
  if cpu_winner?(brd)
    scr[:cpu] += 1
  elsif player_winner?(brd)
    scr[:player] += 1
  elsif draw(brd)
    scr[:draw] += 1
  else
    scr
  end
end

def game_winner(scr)
  if scr[:cpu] == 5
   prompt("CPU wins THE GAME")
  elsif scr[:player] == 5
   prompt("PLAYER wins THE GAME")
  else
    prompt("The game continues.")
  end
end
# PREINITIALIZATION

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

score_board = {cpu: 0, player: 0, draw: 0}

# FLOW

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
  score(board_state, score_board)
  prompt("The score is CPU #{score_board[:cpu]} vs Player #{score_board[:player]} with #{score_board[:draw]} draws.")
  game_winner(score_board)
  prompt('Do you want to play again? (Y/N)')
  again = gets.chomp
  again.casecmp?('n') ? prompt("Goodbye!") : false
  break if again.casecmp?('n')

end
