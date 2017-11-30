PLAYER_SYM = 'X'
COMPUTER_SYM = 'O'
WIN = [ [1, 2, 3], [4, 5, 6], [7, 8, 9], \
                       [1, 4, 7], [2, 5, 8], [3, 6, 9], \
                       [1, 5, 9], [3, 5, 7] ] 
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

def initialize_board
  hash = Hash.new(' ')
  (1..9).each {|i| hash[i] = ' '}
  hash
end

def valid_choice(brd)
  brd.select do |k, v|
    brd[k] == ' '
  end
end

def display_valid_choice(brd)
  hash = valid_choice(brd)
  if  hash.keys.size ==  1
    hash.keys.join(' ')
  elsif hash.keys.size > 1
    hash.keys.insert(-2, 'or').join(' ') 
  else
   prompt("NO CHOICE LEFT")
  end
end 

def player_turn!(brd)
  prompt("Time to make your move.")
  
  loop do
  break if valid_choice(brd).keys.empty? 
    prompt("Choose #{display_valid_choice(brd)}")
    player_choice = gets.chomp.to_i
  
    if valid_choice(brd).keys.include?(player_choice)
      brd[player_choice] = PLAYER_SYM
    break
    else
      prompt("Invalid choice. Try again.")
    end 
      
  end
  display_board(brd)
end

def cpu_turn!(brd)
  prompt("Computer's turn.")
  brd[valid_choice(brd).keys.sample] = COMPUTER_SYM
  
  display_board(brd)
end

def game_over?(brd)
  case
  when valid_choice(brd).empty?
    prompt("No more moves. It's a draw.")
    true
  when cpu_winner?(brd)
    prompt("You lose!")
    true
  when player_winner?(brd)
    prompt("You win!")
    true
  else
    false
  end
end

def cpu_winner?(brd)
  cpu_board_state = brd.select do |k, v|
    v == 'O'
  end
  WIN.include?(cpu_board_state.keys) ? true : false
end
      
def player_winner?(brd)
  player_board_state = brd.select do |k, v|
    v == 'X'
  end
  WIN.include?(player_board_state.keys) ? true : false
end

def player_first?
  prompt("Do you want to go first? (Y/N)")
  first = gets.chomp
  if first.downcase == 'y'
    prompt("Player plays first.")
    true
  else 
   prompt("Computer plays first.")
   false
  end
end

def player_first_loop(brd)
  loop do
    player_turn!(brd)
  break if game_over?(brd)
    cpu_turn!(brd)
  break if game_over?(brd) 
  end
end

def cpu_first_loop(brd)
  loop do
   cpu_turn!(brd)
  break if game_over?(brd)
   player_turn!(brd)
   break if game_over?(brd)
  end
end

board_state = initialize_board

display_board(board_state)


loop do
  board_state = initialize_board
  display_board(board_state)
 
  #choose_difficulty  prompt("Do you want to play Tic Tac Toe? (Y/N)")
  play = gets.chomp.downcase
  break if play == 'n'

  display_board(board_state)
  prompt("You have the #{PLAYER_SYM} and computer the #{COMPUTER_SYM}.")


  if player_first?
    player_first_loop(board_state)
  else
    cpu_first_loop(board_state)
  end
  
  prompt("Game over!")
  prompt("Do you want to play again? (Y/N)")
  again = gets.chomp
  again.downcase == 'n' ? prompt("Goodbye!")
  break if again.downcase == 'n'
 
end









