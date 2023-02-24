require "gosu"
require "./player"
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end
class Ranking
		attr_accessor :readrank
	def initialize
	@size = [660,460,20]
		#read file
		ranking_file = File.new("media/Ranking.txt", "r")
		@readrank =  read_ranking(ranking_file)
		ranking_file.close()
	
	end
	
	def read_ranking txtfile
			rank_num = txtfile.gets.chomp.to_i
			ranking = Array.new(rank_num)
			for i in 0..(rank_num-1)
				name = txtfile.gets.chomp
				score = txtfile.gets.chomp.to_i
				p_ranking = Read_rank.new(name, score)
				ranking[i] = p_ranking
			end	
			ranking
		end
		
		def upate_ranking 
			score = @c_arr[2].score
			for i in 0..@readrank.length-1
				if @readrank[i].uscore <= score
					@readrank[i].uscore = score
					
				break
				end	
			end
			ranking_file = File.new("media/Ranking.txt", "w")
			ranking_file.puts @readrank.length
			for i in 0..@readrank.length-1
					ranking_file.puts @readrank[i].uname
					ranking_file.puts @readrank[i].uscore
			end
			ranking_file.close()
		end
	
	def draw
		Gosu.draw_rect(0, 0, @size[0], @size[1], Gosu::Color.argb(0xff_3399ff), ZOrder::BACKGROUND)
		Gosu::Font.new(30).draw_text("Player Ranking", 10, 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color::WHITE)
		position = [150,130]
		for i in 0..@readrank.length-1
			Gosu::Font.new(30).draw_text("Top #{i+1}.#{@readrank[i].uname}____________#{@readrank[i].uscore}", position[0], position[1], ZOrder::TOP, 1.0, 1.0, Gosu::Color::WHITE)
			position[1]+=70
		end
	end



end
	
class Cover 
		attr_accessor :player2, :button
		
	def initialize
		@size = [660,460,20]
		# super @size[0],@size[1]
		# self.caption ="Snake"
		@ramking_P = false
		@player2 = false
		@button = [[[14,7],[14,8],[15,7],[15,8],[16,7],[16,8],[17,7],[17,8],[18,7],[18,8]],
		[[14,10],[14,11],[15,10],[15,11],[16,10],[16,11],[17,10],[17,11],[18,10],[18,11]],
		[[14,13],[14,14],[15,13],[15,14],[16,13],[16,14],[17,13],[17,14],[18,13],[18,14]]]
	
	end
	def draw
		Gosu.draw_rect(0, 0, @size[0], @size[1], Gosu::Color.argb(0xff_3399ff), ZOrder::BACKGROUND)
		if !@ramking_P
			menu = ["Player 1","Player 2","Ranking"]
			w_move = 290
			h_move = 148
			x_cell = 7
			for a in 0..menu.length-1
			y_cell = 14
			for y in x_cell..x_cell+1
					for x in y_cell..y_cell + 4
					Gosu.draw_rect(x * @size[2], y.to_i * @size[2], @size[2], @size[2], Gosu::Color.argb(0xff_ffffff), ZOrder::MIDDLE)
					end
					Gosu::Font.new(25).draw_text("#{menu[a]}",w_move, h_move, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
				end
			h_move+=60
			x_cell += 3
			end
		end
	end
end

class Read_rank
	attr_accessor :uname,:uscore
	def initialize(name,score)
	@uname = name
	@uscore = score
	end
end

class Main < Gosu::Window


	def initialize
		@size = [660,460,20]
		super @size[0],@size[1]
		self.caption ="Snake"
		@rank = false
		@play = false
	end
	
	def update
		if Gosu.button_down? Gosu::KB_UP
			Snake.new.S_move_up
		elsif Gosu.button_down? Gosu::KB_DOWN
			Snake.new.S_move_down
		elsif Gosu.button_down? Gosu::KB_LEFT
			Snake.new.S_move_left
		elsif Gosu.button_down? Gosu::KB_RIGHT
			Snake.new.S_move_right
		end
		
		Snake.new.S_move
		print Snake.new.S_positions.to_s + "\n"
	end
	
	def draw
		if !@rank and !@play
			Cover.new.draw
		elsif @rank and !@play
			Ranking.new.draw
		elsif @play
			col = @size[0] / @size[2]
			row = @size[1] / @size[2]
			for i in 0..col
				for x in 0..row
					Gosu.draw_rect(i * @size[2], x * @size[2], @size[2], @size[2], Gosu::Color.argb(0xff_006400), ZOrder::BACKGROUND)
				end
			end
			Snake.new.draw
			# Ball.new.draw
		end
		
	end
	
	def needs_cursor?
		true
	end
	
	def speed_up (score)#increase the speed of the snake according to the score
		case score
		when 10
			@speed = 0.09
		when 20
			@speed = 0.08
		when 30
			@speed = 0.07
		when 40
			@speed = 0.06
		when 50
			@speed = 0.04
		when 60
			@speed = 0.03
		end
		
	end
	
	def mouse_over_cell(mouse_x, mouse_y)
		if mouse_x <= @size[2]
		  cell_x = 0
		else
		  cell_x = (mouse_x / @size[2]).to_i
		end

		if mouse_y <= @size[2]
		  cell_y = 0
		else
		  cell_y = (mouse_y / @size[2]).to_i
		end

		[cell_x, cell_y]
	end
	

	def button_down(id)
	##--KB Input--##
	if id == Gosu::KB_ESCAPE #Quit Game
		close
	elsif id == Gosu::KB_B	#Back to Menu Page
		@rank = false
	end
	##--Mouse Input--##
	case id	
		when Gosu::MsLeft 
			cell = mouse_over_cell(mouse_x, mouse_y)
			if Cover.new.button[0].include? cell# Start the Game with 1 player
				puts "1"
				@play = true
			elsif Cover.new.button[1].include? cell# Start the Game with 2 players
				puts "2"
			elsif Cover.new.button[2].include? cell# View the Rank Page
				@rank = true
			else
				super
			end
		end
	end

end

Main.new.show