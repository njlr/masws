for i in {1..100}
do
	./file-grabber.sh "http://www.giantbomb.com/api/franchise/3025-"$i"/?format=xsml&api_key=45d204ae5c940b5b16de5c16db2afaa9e0851940" "./downloads/franchises/franchise-"$i".xml"
done
