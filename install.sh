cd /var/www/html
# rm -r *

apt-get update && apt-get -y install wget nano git-core curl build-essential openssl libssl-dev python p7zip unzip
wget https://buildbot.libretro.com/nightly/emscripten/$(date +%Y-%m-%d -d "1 day ago")_RetroArch.7z

p7zip -d $(date +%Y-%m-%d -d "1 day ago")_RetroArch.7z
mkdir -p assets/frontend/bundle
mkdir -p assets/cores
chmod +x indexer

cd assets/frontend/bundle
wget https://buildbot.libretro.com/assets/frontend/bundle.zip
unzip bundle.zip
cd /var/www/html

### coffee installation
git clone https://github.com/nodejs/node.git && cd node
./configure
make -j4
make install
npm install -g coffee-script

cd /var/www/html/assets/frontend/bundle
../../../indexer > .index-xhr

cd /var/www/html/assets/cores
../../indexer > .index-xhr