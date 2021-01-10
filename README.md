# vimConfig
my new vim config

#install (opensuse)
zypper in cargo
zypper in libopenssl-devel
zypper in ripgrep
zypper in npm
zypper in git

sudo npm i intelephense -g
zypper in cmake
zypper in clang
sudo npm i -g sql-language-server
sudo npm i -g tailwindcss@latest postcss@latest autoprefixer@latest


in vim
:Pluginstall
:CocInstall coc-go coc-html coc-json coc-css coc-tsserver coc-cmake coc-sh coc-tailwindcss
