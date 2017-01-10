require 'singleton'
require './Cell.rb'
require './QueenAnt.rb'
require './RoomWarrior.rb'
require './RoomBuilder.rb'
require './RoomForager.rb'

# Meadow class that encapsulates the play ground for ants
# Implements the singleton pattern so just a single instance of Meadow class can be created
# Director class of the builder class
class Meadow
	include Singleton
	@@roundCounter = 1

	# Create a 25 by 25 grid to simulate a ant farm
	def initialize
		@meadow = Array.new(25) {Array.new(25)}

		for i in 0..24
			for j in 0..24
				@meadow[i][j] = Cell.new()
			end
		end
	end

	# Creates meadow with ant hills and foods at random locations
	def meadowGrow()
		# 250 pieces of food are placed at random locations
		for i in 0..250
			x_index = rand(0..24)
			y_index = rand(0..24)

			@meadow[x_index][y_index].setFood()	
		end
	end

	# Prints the current situation of the meadow to the screen
	def showMeadowFood()
		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getFood())
					printf("T  ")
				else
					printf("F  ")
				end	
			end
			puts("\n\n")
		end
	end

	#shows anthills on the meadow
	def showMeadowAnthill()
		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getHill())
					printf(@meadow[i][j].getHill().getName())
				else
					printf("F  ")
				end
			end
			puts("\n\n")
		end
	end

	#shows ants on the meadow
	def showMeadowAnts()
		for i in 0..24
			for j in 0..24
				ants = @meadow[i][j].getAnts()
				length = ants.length

				if (length == 0)
					printf("F ")
				else
					for a in 0..(length-1)
						printf(ants[a].getType().to_s)
					end
					printf(" ")
				end
			end
			puts("\n\n")
		end
	end

	#spawning anthills on the meadow by queen ant
	def spawnAnthills()
		for i in 1..10
			@meadow = QueenAnt.new().addName("Anthill" + i.to_s + " ").addLocation(@meadow).build()
		end
	end

	#spawning ants on the meadow according to their ant types
	def spawnAnts()
		for i in 0..24
			for j in 0..24
				
				if (@meadow[i][j].getHill())
					name = @meadow[i][j].getHill().getName()

					while (@meadow[i][j].getHill().getNumOfFood > 0) 
						r = rand(4)

						if (r == 0 && @meadow[i][j].getHill().getNumOfWarriorRoom() > 0)
							ant = RoomWarrior.new.createAnt(RoomWarrior, name)

							@meadow[i][j].getHill().spendWarriorRoom()
							@meadow[i][j].getHill().addAnt(ant)
							@meadow[i][j].getHill().spendFood()
						elsif (r == 1 && @meadow[i][j].getHill().getNumOfBuilderRoom() > 0)
							ant = RoomBuilder.new.createAnt(RoomBuilder, name)

							@meadow[i][j].getHill().spendBuilderRoom()
							@meadow[i][j].getHill().addBuilderAnt(ant)
							@meadow[i][j].getHill().spendFood()
						elsif ((r == 2 || r == 3) && @meadow[i][j].getHill().getNumOfForagerRoom() > 0)
							ant = RoomForager.new.createAnt(RoomForager, name)

							@meadow[i][j].getHill().spendForagerRoom()
							@meadow[i][j].getHill().addAnt(ant)
							@meadow[i][j].getHill().spendFood()
						end
					end
				end
			end
		end
	end

	#initial movement for ants
	def moveAntsFromHills()
		for i in 0..24
			for j in 0..24
				
				if (@meadow[i][j].getHill())
					hill = @meadow[i][j].getHill()
					ants = hill.getAnts()

					for a in 0..(ants.length()-1)
						randomNumber = rand(4)
						ant = ants[a]
						randomNumber = checkBorders(i, j, randomNumber)

						if (randomNumber == 0)
							# moves right
							@meadow[i][j+1].setAntToCell(ant)
							@meadow[i][j].deleteAnt()
						elsif (randomNumber == 1)
							# moves left
							@meadow[i][j-1].setAntToCell(ant)
							@meadow[i][j].deleteAnt()
						elsif (randomNumber == 2)
							# moves up
							@meadow[i-1][j].setAntToCell(ant)
							@meadow[i][j].deleteAnt()
						elsif (randomNumber == 3)
							# moves down
							@meadow[i+1][j].setAntToCell(ant)
							@meadow[i][j].deleteAnt()
						end
					end 
				end
			end
		end
	end

	#rest of the ant movement, movement that they left from the anthill
	def moveFreeAnts()
		for i in 0..24
			for j in 0..24
				ants = @meadow[i][j].getAnts()
				numOfAnts = ants.length

				for a in 0..numOfAnts-1
					randomNumber = rand(4)
					ant = ants[a]
					randomNumber = checkBorders(i, j, randomNumber)

					if (randomNumber == 0)
						# moves right
						@meadow[i][j+1].setAntToCell(ant)
					elsif (randomNumber == 1)
						# moves left
						@meadow[i][j-1].setAntToCell(ant)
					elsif (randomNumber == 2)
						# moves up
						@meadow[i-1][j].setAntToCell(ant)
					elsif (randomNumber == 3)
						# moves down
						@meadow[i+1][j].setAntToCell(ant)
					end
				end

				for b in 0..numOfAnts-1
					@meadow[i][j].deleteAnt()
				end
			end
		end
	end

	#checking whether there is a food or not on the cell.If there is, forager ant obtains it
	def checkCollisionsForFood()
		for i in 0..24
			for j in 0..24
				ants = @meadow[i][j].getAnts

				if (ants.length > 0 && ants[0].getType == RoomForager && @meadow[i][j].getFood())
					@meadow[i][j].consumeFood()
					hillName = ants[0].getHill()

					for a in 0..24
						for b in 0..24
							if (@meadow[a][b].getHill != false && @meadow[a][b].getHill.getName() == hillName)
								@meadow[a][b].getHill.addFood()
							end
						end
					end
				end
			end
		end
	end

	#checking whether there is a colony kill or not.If there is, anthill set to false
	def checkCollisionsForHill()
		for i in 0..24
			for j in 0..24
				ants = @meadow[i][j].getAnts

				if (ants.length > 0 && ants[0].getType == RoomWarrior && @meadow[i][j].getHill())
					if (ants[0].getHill() != @meadow[i][j].getHill())
						r = rand(5)

						if (r == 0)
							killCounter(ants[0].getHill(), "colony")
							@meadow[i][j].setHill(false)
						end
					end
				end
			end
		end
	end

	#checking whether there is a battle between ants or not. Warriors always kill foragers, figths their opponents with random percentage
	def checkCollisonsForBattle()
		for i in 0..24
			for j in 0..24
				ants = @meadow[i][j].getAnts

				if (ants.length > 1)
					a1 = ants[0]
					a2 = ants[1]

					if (a1.getHill() != a2.getHill())
						if (a1.getType == RoomWarrior && a2.getType == RoomWarrior)
							r = rand(2)

							if (r == 0)
								hillName = a1.getHill()
								killAnt(hillName, RoomWarrior)
								@meadow[i][j].deleteAntAtIndex(0)

								killCounter(a2.getHill(), "ant")
							else
								hillName = a2.getHill()
								killAnt(hillName, RoomWarrior)
								@meadow[i][j].deleteAntAtIndex(1)

								killCounter(a1.getHill(), "ant")
							end

						elsif (a1.getType == RoomForager && a2.getType == RoomWarrior)
							hillName = a1.getHill()
							killAnt(hillName, RoomForager)
							@meadow[i][j].deleteAntAtIndex(0)

							killCounter(a2.getHill(), "ant")

						elsif (a1.getType == RoomWarrior && a2.getType == RoomForager)
							hillName = a2.getHill()
							killAnt(hillName, RoomForager)
							@meadow[i][j].deleteAntAtIndex(1)

							killCounter(a1.getHill(), "ant")
						end
					end
				end
			end
		end
	end

	#starting point of the program.
	def startCycle()
		meadowGrow()
		spawnAnthills()
		numOfCollonies = 2
		outputCounter = 0

		while (numOfCollonies > 1)
			numOfCollonies = 0
			outputCounter = outputCounter + 1

			spawnAnts()
			moveAntsFromHills()
			moveFreeAnts()

			checkCollisionsForFood()
			checkCollisionsForHill()
			checkCollisonsForBattle()

			if ((outputCounter % 5) == 0)
				output()
			end

			buildRoom()

			for i in 0..24
				for j in 0..24 
					if (@meadow[i][j].getHill())
						numOfCollonies = numOfCollonies + 1
					end
				end
			end

		end

		output()
	end

	#checking meadow borders in order not to reach
	def checkBorders(i, j, randomNumber)
		r = rand(0..1)
		rr = rand(0..2)

		if (i == 0 && j == 0)
			if (r == 0)
				randomNumber = 0
			else
				randomNumber = 3
			end
		elsif (i == 0 && j == 24)
			if (r == 0)
				randomNumber = 1
			else
				randomNumber = 3
			end
		elsif (i == 24 && j == 0)
			if (r == 0)
				randomNumber = 0
			else
				randomNumber = 2
			end
		elsif (i == 24 && j == 24)
			if (r == 0)
				randomNumber = 1
			else
				randomNumber = 2
			end
		elsif (i == 0)
			if (rr == 0)
				randomNumber = 1
			elsif (rr == 1)
				randomNumber = 3
			else
				randomNumber = 0
			end
		elsif (i == 24)
			if (rr == 0)
				randomNumber = 1
			elsif (rr == 1)
				randomNumber = 2
			else
				randomNumber = 0
			end
		elsif (j == 0)
			if (rr == 0)
				randomNumber = 2
			elsif (rr == 1)
				randomNumber = 0
			else
				randomNumber = 3
			end
		elsif (j == 24)
			if (rr == 0)
				randomNumber = 2
			elsif (rr == 1)
				randomNumber = 1
			else
				randomNumber = 3
			end
		end

		return randomNumber
	end
	#building room for the ants according to their types
	def buildRoom()
		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getHill)
					builderAnts = @meadow[i][j].getHill.getBuilderAnts()

					for a in 1..builderAnts.length
						ants = @meadow[i][j].getHill.getAnts()
						warriorCounter = 0
						foragerCounter = 0

						for b in 0..ants.length-1
							if (ants[b].getType == RoomWarrior)
								warriorCounter = warriorCounter + 1
							else
								foragerCounter = foragerCounter + 1
							end
						end

						@meadow[i][j].getHill.builderDie()
						@meadow[i][j].getHill.buildBuilderRoom()
						if (foragerCounter <= warriorCounter)
							@meadow[i][j].getHill.buildForagerRoom()
						else
							@meadow[i][j].getHill.buildWarriorRoom()
						end
					end
				end
			end
		end
	end

	#print info of the program
	def output()
		puts("============ ROUND " + @@roundCounter.to_s + " ============")

		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getHill())
					puts("Anthill Name: " + @meadow[i][j].getHill.getName())

					ants = @meadow[i][j].getHill.getAnts()
					warriorCounter = 0
					foragerCounter = 0

					for b in 0..ants.length-1
						if (ants[b].getType == RoomWarrior)
							warriorCounter = warriorCounter + 1
						else
							foragerCounter = foragerCounter + 1
						end
					end

					puts("Forager Ants: " + foragerCounter.to_s)
					puts("Warrior Ants: " + warriorCounter.to_s)
					puts("Builder Ants: " + @meadow[i][j].getHill.getBuilderAnts.length.to_s)
					puts("Ant Kill: " + @meadow[i][j].getHill.getAntKill.to_s)
					puts("Colony Kill: " + @meadow[i][j].getHill.getColonyKill.to_s)
					puts("------------------")
				end
			end
		end

		@@roundCounter = @@roundCounter + 1
	end
	#method for killing ants
	def killAnt(hillName, antType)
		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getHill() != false && @meadow[i][j].getHill().getName() == hillName)
					@meadow[i][j].getHill().kill(antType)
				end
			end
		end
	end
	#kill counter for the both colony kill and ant kill
	def killCounter(hillName, killType)
		for i in 0..24
			for j in 0..24
				if (@meadow[i][j].getHill() != false && @meadow[i][j].getHill().getName() == hillName)
					if (killType == "colony")
						@meadow[i][j].getHill().increaseColonyKill()
					elsif (killType == "ant")
						@meadow[i][j].getHill().increaseAntKill()
					end
				end
			end
		end
	end
end