def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return index = input.to_i - 1
end

def move(board, index, character)
  board[index]=character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index >=0 && index<=8
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board,index)==true
    move(board,index,character)
    puts display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter +=1
  end
end
return counter
end

#WHICH PLAYER IS THIS?
def current_player(board)
  if turn_count(board)%2 ==0
    current_player = "X"
  else
    current_player = "O"
end
return current_player
end

WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1=="X" && position_2=="X"&& position_3=="X" || position_1=="O" && position_2=="O"&& position_3=="O"
      return win_combination
    end
    end
    return false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || draw?(board)==true 
    return true
  else
    return false
  end
end

def winner(board)
  winner = nil
    WIN_COMBINATIONS.each do |winner_counter|
      if winner_counter.all? {|idx| board[idx] == "X"}
        winner = "X"
      elsif winner_counter.all? {|idx| board[idx] == "O"}
        winner = "O"
      else
        winner = nil
      end
    end
  return winner
end



def play(board)
  until over?(board) == true || won?(board) != false
    turn(board)
  end
  
  if winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    return nil
  end
end
