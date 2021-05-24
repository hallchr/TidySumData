##Mutating filters and joins

#Inner Join - only keep observations found in both x and y
#Left Join - keep all observations in x
#Right Join - keep all observations in y
#Full Join - keep any observations in x or y

##See Relational_DB_SQL.R for the script for getting the SQL data used here.

## do inner join
inner <- inner_join(artists, albums, by = "ArtistId")

## look at output as a tibble
as_tibble(inner)

## do left join
left <- left_join(artists, albums, by = "ArtistId")

## look at output as a tibble
as_tibble(left)

## do right join
right <- right_join(as_tibble(artists), as_tibble(albums), by = "ArtistId")

## look at output as a tibble
as_tibble(right)

## do right join
full <- full_join(as_tibble(artists), as_tibble(albums), by = "ArtistId")

## look at output as a tibble
as_tibble(full)


#Filtering joins keep observations in one table based on the observations present in a second table. 
#Specifically:
  
  #semi_join(x, y) : keeps all observations in x with a match in y.
  #anti_join(x, y) : keeps observations in x that do NOT have a match in y.

semi_join(artists, albums)

anti_join(artists,albums)