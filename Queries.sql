1. "Not" Query
List the Moves that are not a Status Category and their Power.

SELECT MOVE_NAME, CATEGORY, POWER
FROM MOVE
WHERE CATEGORY NOT IN 'Status' AND POWER >= 150;

2. "Greater/Less Than" Query
List the Dragon Species Pokemon thats Weight is more than 200 pounds.

SELECT POKEMON_NAME, SPECIES, WEIGHT_LBS
FROM POKEMON
WHERE SPECIES = 'Dragon' AND WEIGHT_LBS > 200;

3. "Arithmetic" Query
List the Pokemon thats Height is taller than 10 feet.

SELECT POKEMON_NAME, HEIGHT_FEET, HEIGHT_INCH
FROM POKEMON
WHERE HEIGHT_FEET + HEIGHT_INCH /12 > 10
ORDER BY HEIGHT_FEET + HEIGHT_INCH / 12;

4. "Like" Query
List the Pokemon that have the term "chu" in the end of their Name and what is their Element.

SELECT POKEMON_NAME
FROM POKEMON
WHERE POKEMON_NAME LIKE '%chu';

5. "Or", "JOIN" Query
List the Pokemon that can be found in the Location Route 1 or Route 2.

SELECT POKEMON_NAME, LOCATION_NAME
FROM POKE_LOCATION
INNER JOIN POKEMON ON POKEMON.POKEMON_ID = POKE_LOCATION.POKEMON_ID
INNER JOIN LOCATION ON LOCATION.LOCATION_ID = POKE_LOCATION.LOCATION_ID
WHERE LOCATION_NAME = 'Route 1' OR LOCATION_NAME = 'Route 2';

6. "ORDER BY","ROWNUM" Query
POKEBALL WITH HIGHEST CATCH RATE

SELECT *
FROM (SELECT TYPE, CATCH_RATE
FROM POKEBALL
ORDER BY CATCH_RATE DESC)
WHERE ROWNUM = 1;

7. "Null","JOIN" Query
List the Trained Pokemon of the Trainer that doesn't have a specialized 
Element and what is that Trainer’s Name and pokemon.'

SELECT TRAINER_NAME, POKEMON_NAME
FROM TRAINED_POKEMON
INNER JOIN POKEMON ON TRAINED_POKEMON.POKEMON_ID =POKEMON.POKEMON_ID
INNER JOIN  TRAINER ON TRAINED_POKEMON.TRAINER_ID = TRAINER.TRAINER_ID
WHERE TRAINER.ELEMENT_ID IS NULL;

8. "Group BY","NESTED","MAX","SUM","JOIN","ORDER BY","NOT NULL" Query
Find the Pokemon that knows the highest combined Power out of all of its 
Moves.

SELECT *
FROM(
SELECT POKEMON_NAME, MAX(POWERS)
FROM
(SELECT POKEMON.POKEMON_ID,SUM(POWER) AS POWERS
FROM POKE_MOVE
INNER JOIN POKEMON ON POKEMON.POKEMON_ID = POKE_MOVE.POKEMON_ID
INNER JOIN MOVE ON MOVE.MOVE_ID = POKE_MOVE.MOVE_ID
WHERE POWER IS NOT NULL
GROUP BY POKEMON.POKEMON_ID ORDER BY SUM(POWER)) P1
INNER JOIN POKEMON ON POKEMON.POKEMON_ID = P1.POKEMON_ID
GROUP BY POKEMON_NAME
ORDER BY MAX(Powers) DESC)
WHERE ROWNUM = 1;

9. Find the Pokemon with highest combined stats of (ATTACK, DEFENSE, SP_ATTACK, SP_DEFENSE , SPEED)

SELECT *
FROM(
SELECT POKEMON_NAME,HP + ATTACK + DEFENSE + SP_ATTACK + SP_DEFENSE + SPEED AS HIGHEST_STATS 
FROM POKEMON
ORDER BY HIGHEST_STATS DESC
)
WHERE ROWNUM = 1;

10. Challenging Query
FIND THE NAME, LONGITUDE AND LATITUDE OF THE LOCATION LOCATED IN THHE 'Shizuoka' PREFECTURE WHICH THE Water Element Trained Pokémon 
that knows a Normal Move with the Power of 40 that belongs to an Egg Group 'Monster' as well as its Trainer & Ball Name.

SELECT Pokemon.POKEMON_NAME, Pokemon.SPECIES, Move.POWER, Element_1.ELEMENT_NAME, Location.LOCATION_NAME, Location.LONGITUDE, Location.LATITUDE, Trainer.TRAINER_NAME, Pokeball.TYPE
FROM Trainer 
INNER JOIN Pokemon
INNER JOIN Egg_Group 
INNER JOIN Poke_Egg ON Egg_Group.egg_group_ID = Poke_Egg.EGG_GROUP_ID ON Pokemon.pokemon_ID = Poke_Egg.POKEMON_ID 
INNER JOIN Element 
INNER JOIN Poke_Element ON Element.element_ID = Poke_Element.ELEMENT_ID ON Pokemon.pokemon_ID = Poke_Element.POKEMON_ID 
INNER JOIN Location 
INNER JOIN Poke_Location ON Location.location_ID = Poke_Location.LOCATION_ID ON Pokemon.pokemon_ID = Poke_Location.POKEMON_ID 
INNER JOIN Move 
INNER JOIN Poke_Move ON Move.move_ID = Poke_Move.MOVE_ID ON Pokemon.pokemon_ID = Poke_Move.POKEMON_ID 
INNER JOIN Pokeball 
INNER JOIN Trained_Pokemon ON Pokeball.pokeball_ID = Trained_Pokemon.POKEBALL_ID ON Pokemon.pokemon_ID = Trained_Pokemon.POKEMON_ID ON Trainer.trainer_ID = Trained_Pokemon.TRAINER_ID 
INNER JOIN (Element) Element_1 ON Move.ELEMENT_ID = Element_1.element_ID
WHERE Element.ELEMENT_NAME='Water' AND Egg_Group.EGG_NAME='Monster' AND Move.POWER=40 AND Element_1.ELEMENT_NAME='Normal' AND Location.PREFECTURE='Shizuoka';













