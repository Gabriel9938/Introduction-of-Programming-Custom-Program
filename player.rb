class Ball
	attr_accessor :score, :p2score, :player2, :p1grow, :p2grow
	
	def initialize
	@size = [660,460,20]
	@Snake = Snake.new
	@score = 0
	@player2 = false
	@p1grow = false
	@p2grow = false
	@p2score = 0
	@CELL_DIM = 20
	@win_width1 = 660 / @CELL_DIM
	@win_heigh1 = 460	/ @CELL_DIM
	@ball_x = rand(660 / @CELL_DIM)
	@ball_y = rand(460	/ @CELL_DIM)
	
	
	end
	
	def draw
			Gosu.draw_rect(@ball_x.to_i * @CELL_DIM, @ball_y.to_i * @CELL_DIM, @CELL_DIM, @CELL_DIM, Gosu::Color.argb(0xff_FFFF00), ZOrder::MIDDLE)
			
			if player2
				Gosu::Font.new(20).draw_text("P1_Score: #{@score}", 10, 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color.argb(0xff_00ac2c))
				Gosu::Font.new(20).draw_text("P2_Score: #{@p2score}", 150, 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color.argb(0xff_00ac2c))
			else
				Gosu::Font.new(20).draw_text("P1_Score: #{@score}", 10, 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color.argb(0xff_00ac2c))
			end
	end

	def get_score (pos,pos2)
		if @ball_x == pos[0] and @ball_y == pos[1]
			@score += 1
			@ball_x = rand(@win_width1)
			@ball_y = rand(@win_heigh1)
			@p1grow = true
		elsif@ball_x == pos2[0] and @ball_y == pos2[1]
			@p2score+=1
			@ball_x = rand(@win_width1)
			@ball_y = rand(@win_heigh1)
			@p2grow = true
		end
			
		end
	end
	
class Snake
	attr_accessor :growing, :S_positions
	
	def initialize
		@size = [660,460,20]
		@S_positions = [[2,0],[2,1],[2,2],[2,3]] # Psition of the snake
		@direction = "down"
		@CELL_DIM = 20
		@win_width1 = 660 / @CELL_DIM
		@win_heigh1 = 460	/ @CELL_DIM
		@growing = 1
		@finish = false
	end
	#Control Snake
	def S_move_up
		if @direction != "down"
			@direction = "up"
		end
	end
	
	def S_move_down
		if @direction != "up"
			@direction = "down"
		end
	end
	
	def S_move_left
		if @direction != "right"
			@direction = "left"
		end
	end
	
	def S_move_right
		if @direction != "left"
			@direction = "right"
		end
	end
	#How the Snake will move
	def S_move
		if @growing != 0
			@S_positions.shift
		end	
		
		case @direction
			when " "
				@S_positions.push(over(s_head[0], s_head[1]))
			when "up"
				@S_positions.push(over(s_head[0], s_head[1] - 1))
			when "down"
				@S_positions.push(over(s_head[0], s_head[1] + 1))
			when "left"
				@S_positions.push(over(s_head[0] - 1, s_head[1]))
			when "right"
				@S_positions.push(over(s_head[0] + 1, s_head[1]))
		end
		@growing = 1
	end

	
	def over(x,y)
		[x%@win_width1,y%@win_heigh1]
	end
	
	
	#Display the snake
	def draw
	x = 0
		while x != @S_positions.length
			Gosu.draw_rect(@S_positions[x][0].to_i * @CELL_DIM, @S_positions[x][1].to_i * @CELL_DIM, @CELL_DIM-1, @CELL_DIM-1, Gosu::Color.argb(0xff_00FF00), ZOrder::MIDDLE)
			x += 1
		end
	end
	
	def head
		@S_positions
	end
	def s_head
		@S_positions.last
	end
	
	def grow
		@growing = 0
	end
	
	def eat_itself
			if @S_positions.uniq.length != @S_positions.length
				@finish = false
			else
				@finish = true
		end
	end

end
	
	
class Snake2
	attr_accessor :growing, :S_positions
	
	def initialize
		
		@S_positions = [[30,0],[30,1],[30,2],[30,3]] # Psition of the snake
		@direction = "down"
		@CELL_DIM = 20
		@win_width1 = 660 / @CELL_DIM
		@win_heigh1 = 460	/ @CELL_DIM
		@growing = 1
		@finish = false
	end
	#Control Snake
	def S_move_up
		if @direction != "down"
			@direction = "up"
		end
	end
	
	def S_move_down
		if @direction != "up"
			@direction = "down"
		end
	end
	
	def S_move_left
		if @direction != "right"
			@direction = "left"
		end
	end
	
	def S_move_right
		if @direction != "left"
			@direction = "right"
		end
	end
	#How the Snake will move
	def S_move
		if @growing != 0
			@S_positions.shift
		end	
		
		case @direction
			when "up"
				@S_positions.push(over(s_head[0], s_head[1] - 1))
			when "down"
				@S_positions.push(over(s_head[0], s_head[1] + 1))
			when "left"
				@S_positions.push(over(s_head[0] - 1, s_head[1]))
			when "right"
				@S_positions.push(over(s_head[0] + 1, s_head[1]))
		end
		@growing = 1
	end
	
	def over(x,y)
		[x%@win_width1,y%@win_heigh1]
	end
	
	#Display the snake
	def draw
	x = 0
		while x != @S_positions.length
			Gosu.draw_rect(@S_positions[x][0].to_i * @CELL_DIM, @S_positions[x][1].to_i * @CELL_DIM, @CELL_DIM-1, @CELL_DIM-1, Gosu::Color.argb(0xff_90EE90), ZOrder::MIDDLE)
			x += 1
		end
	end
	
	def head
		@S_positions
	end
	
	def s_head
		@S_positions.last
	end
	
	def grow2
		@growing = 0
	end
	
	def eat_itself
		if @S_positions.uniq.length != @S_positions.length
			@finish2 = false
		else
			@finish2 = true
		end
	end

end