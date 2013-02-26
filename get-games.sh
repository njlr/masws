for i in {101..600}
do
	./file-grabber.sh "http://www.giantbomb.com/api/game/3030-"$i"/?format=xsml&api_key=45d204ae5c940b5b16de5c16db2afaa9e0851940" "./downloads/games/game-"$i".xml"
done
