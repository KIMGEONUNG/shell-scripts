apt update
apt install -y sudo

# Install vim 8.2
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Create vimrc 
cat vimrc.sample >> ~/.vimrc

# Install vimspector
mkdir -p $HOME/.vim/pack
git clone https://github.com/puremourning/vimspector ~/.vim/pack/vimspector/opt/vimspector

pushd ~/.vim/pack/vimspector/opt/vimspector
./install_gadget.py --all
popd 
