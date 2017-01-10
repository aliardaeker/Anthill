# Represents cell objects of the 25 by 25 grid
class Cell
	def initialize()
		@hill = false
		@food = false
		@ants = Array.new()
	end

	def getFood()
		@food
	end

	def setFood()
		@food = true
	end

	def consumeFood()
		@food = false
	end	

	def getHill()
		@hill
	end

	def setHill(hill)
		@hill = hill
	end

	def setAntToCell(a)
		@ants.push(a)
	end

	def deleteAntAtIndex(index)
		@ants.delete_at(index)
	end

	def deleteAnt()
		@ants.pop()
	end

	def getAnts()
		@ants
	end
end