for i in {101..1000}
do
	./file-grabber.sh "http://www.giantbomb.com/api/character/3005-"$i"/?format=xsml&api_key=45d204ae5c940b5b16de5c16db2afaa9e0851940" "./downloads/characters/character-"$i".xml"
done
