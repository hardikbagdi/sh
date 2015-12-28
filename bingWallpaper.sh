#author: Hardik Bagdi (hardikbagdi@gmail.com)

#ping url
requestURL="http://www.bing.com/HPImageArchive.aspx?&format=js&idx=0&mkt=en-US&n=1"
#echo "pinging $requestURL"
#ping using curl
echo "Downloading Image of the Day"
response=$(curl -s $requestURL)

#echo "\nresponse is: $response"
#perl regex match
urlfield=$(echo $response |grep -oP "url\":\"[^\"]*" )
#echo "\nextracted filed: $urlfield"
#
finalBaseURL=$(echo "http://www.bing.com")$(echo $urlfield | cut -d "\"" -f3)
#echo "\nfinal url of the image: $finalBaseURL"
#download to Pictures Directory
wget -q $finalBaseURL -P $HOME/Pictures

imageName=${finalBaseURL##*/}
#echo "\nname of the image: $imageName"

gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/$imageName"
echo "Wallpaper Updated"