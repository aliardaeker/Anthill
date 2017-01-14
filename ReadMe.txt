Ali Arda Eker
Design Patterns 
12/09/2016

	Builder pattern is used to create queen ants which spawn ant hill and factory
pattern is used to create warrior, builder and forager ants. Meadow class
is singleton so there can be only one meadow.
	Builder ants create foregar rooms if number of foragers which belong to a 
specific ant hill is less than or equal to number of warriors which belong to the
same ant hill otherwise they create warrior rooms. Those rooms are used to 
span ants that belong to their room type. 
	The main algorithm of the program is implemented in meadow class.
The cycle loops in there up to there is just 1 ant hill left. In each loop
remaining ant hills spawn all of their ants according to room type they have and 
number of foods. After this, all of the ants on the meadow move single cell within
the borders of the meadow. If forager ants find food, their ant hill's food stock 
is increased, if warriors find ant hill, they destroy it by a chance of %20, 
if a forager and warrior is met, forager dies and in a warrior and warrior meets
then one of them is die by chance. At the end of each cycle new rooms are built 
by the builder ants.
	 
	

	
