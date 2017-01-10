require './Room.rb'
require './Ant.rb'

# Concrete factory class for warrior ants
class RoomWarrior < Room
	def newAnt(t, h)
		ant = Ant.new()
		ant.setType(t)
		ant.setHill(h)
		return ant
	end
end