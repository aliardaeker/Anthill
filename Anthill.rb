# Product class which is produced by ant hills
class Anthill
	def initialize(name)
		@name = name
		@numOfFood = 5

		@numOfWarriorRoom = 10
		@numOfBuilderRoom = 10
		@numOfForagerRoom = 10

		@ants = Array.new()
		@builderAnts = Array.new()

		@antKill = 0
		@colonyKill = 0
	end
	#deleting ant from the program according to its type
	def kill(type)
		for a in 0..@ants.length-1

			if (@ants[a].getType == type)
				@ants.delete_at(a)
				break
			end
		end
	end
	
	def addAnt(a)
		@ants << a
	end

	def addBuilderAnt(a)
		@builderAnts << a
	end

	def getAnts()
		@ants
	end

	def getBuilderAnts()
		@builderAnts
	end

	def getName()
		@name
	end

	def getNumOfFood()
		@numOfFood
	end

	def spendFood()
		@numOfFood = @numOfFood - 1
	end

	def addFood()
		@numOfFood = @numOfFood + 1
	end

	def getNumOfWarriorRoom()
		@numOfWarriorRoom
	end

	def spendWarriorRoom()
		@numOfWarriorRoom = @numOfWarriorRoom - 1
	end

	def getNumOfBuilderRoom()
		@numOfBuilderRoom
	end

	def spendBuilderRoom()
		@numOfBuilderRoom = @numOfBuilderRoom - 1
	end

	def getNumOfForagerRoom()
		@numOfForagerRoom
	end

	def spendForagerRoom()
		@numOfForagerRoom = @numOfForagerRoom - 1
	end

	def antsLength()
		puts(@name)
		puts("-------" + @ants.length.to_s + "---------")
		puts("---" + @builderAnts.length.to_s + "---")
	end

	def builderDie()
		@builderAnts.pop()
	end

	def buildForagerRoom()
		@numOfForagerRoom = @numOfForagerRoom + 1
	end

	def buildWarriorRoom()
		@numOfWarriorRoom = @numOfWarriorRoom + 1
	end

	def buildBuilderRoom()
		@numOfBuilderRoom = @numOfBuilderRoom + 1
	end

	def getColonyKill()
		@colonyKill
	end

	def increaseColonyKill()
		@colonyKill = @colonyKill + 1
	end

	def getAntKill()
		@antKill
	end

	def increaseAntKill()
		@antKill = @antKill + 1
	end
end