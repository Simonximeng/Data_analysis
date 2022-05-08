-- SELECT top 5

SELECT * 
FROM pokemon
LIMIT 5;

-- SELECT 'pikachu'

SELECT * 
FROM pokemon 
WHERE species = 'pikachu';

-- SHOW average of hp, attack, defence

SELECT AVG(attack), AVG(hp), AVG(defense)
FROM pokemon;

-- Show the pokemons that have hp higher than average order by hp 

SELECT id, species, hp
FROM pokemon 
WHERE hp > (SELECT AVG(hp) FROM pokemon)
ORDER BY hp DESC;

-- Show the number of pokemons that have attack and defense higher than average 

SELECT COUNT(DISTINCT species)
FROM pokemon 
WHERE attack > (SELECT AVG(attack) FROM pokemon) 
AND defense > (SELECT AVG(defense) FROM pokemon);

-- Count the number of pokemons that have either grass, fire, water type

SELECT COUNT(DISTINCT id)
FROM pokemon 
WHERE type_1 IN 
	('grass', 'fire', 'water') 
OR type_2 IN 
	('grass', 'fire', 'water');
	
-- Show the hp average for different generation_id in descending order

SELECT AVG(hp), generation_id
FROM pokemon 
GROUP BY generation_id 
ORDER BY AVG(hp) DESC

