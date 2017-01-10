require './Anthill.rb'
require './Cell.rb'

# Builder class create a queen ant which spawns a ant hill
class QueenAnt
	def initialize()
		@meadow = nil
		@name = nil
		@location = nil
		@anthill = nil
		@x_index = nil
		@y_index = nil
	end

	def addName(name)
		@name = name
		return self
	end

	def addLocation(meadow)
		@location = true
		@meadow = meadow

		while(true)
			x = rand(25)
			y = rand(25)

			if (@meadow[x][y].getHill())
			else
				@x_index = x
				@y_index = y

				break
			end	
		end

		return self
	end

	def build()
		if (@name && @location)
			@anthill = Anthill.new(@name)
			@meadow[@x_index][@y_index].setHill(@anthill)
			return @meadow
		end
	end
end