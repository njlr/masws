for i in {1..1000}
do
	./file-grabber.sh "http://www.giantbomb.com/api/releases/?format=xsml&api_key=45d204ae5c940b5b16de5c16db2afaa9e0851940&filter=game:"$i "./downloads/releases/releases-"$i".xml"
done
