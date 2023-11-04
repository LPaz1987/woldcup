if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals

do
	#Leo equipo, verfico que exita 
	if [[ $winner  != "winner"  ]]
	then
		NAME=$($PSQL "select name from teams where name='$winner'")
		#sino existe lo agrego
		if [[ -z $NAME ]]
		then
			INSERT_NAME=$($PSQL "insert into teams(name) values('$winner') ")
			if [[ $INSERT_NAME == "INSERT 0 1" ]]
				then
					echo Inserted into name, $winner
			fi
		fi

	fi

	if [[ $opponent != "opponent" ]]
	then
		O_NAME=$($PSQL "select name from teams where name='$opponent'")
		if [[ -z $O_NAME ]]
		then
			INSERT_O_NAME=$($PSQL "insert into teams(name) values('$opponent')")
			if [[ $INSERT_O_NAME == "INSERT 0 1" ]]
			then
				echo Inserted into name, $opponent
			fi
		fi
	fi

if [[ $year != 'year' ]]
then
	YEAR=$($PSQL "select year from games where year='$year'")
	GET_W=$($PSQL "select team_id from teams where name='$winner'")
	GET_O=$($PSQL "select team_id from teams where name='$opponent'")
		#sino existe lo agrego
	INSERT_ROUND=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values('$year','$round','$GET_W','$GET_O','$winner_goals','$opponent_goals')")
		
	if [[ $INSERT_ROUND == "INSERT 0 1" ]]
	then
		echo Inserted into year,  $year $round $GET_W $GET_O $winner_goals $opponent_goals
	fi
	fi


done

