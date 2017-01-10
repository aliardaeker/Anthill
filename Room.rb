# Base factory class
class Room
	def createAnt(type, hill)
		room = type.new()
		room.newAnt(type, hill)
	end

	def newAnt()
		raise NoMethodError.new
	end
end