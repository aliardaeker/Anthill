# Product factory class which produces ant objects
class Ant
	def initialize()
		@type = nil
		@hillName = nil
	end

	def setType(type)
		@type = type
	end

	def setHill(h)
		@hillName = h
	end

	def getType()
		@type
	end

	def getHill()
		@hillName
	end
end