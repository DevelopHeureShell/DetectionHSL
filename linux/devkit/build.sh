if [ $UID == 0 ]; then
    echo "Ce script ne doit pas être lancé en root!"
    exit 1
fi
if [ ! "$(command -v cargo)" ]; then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > "${PWD}/rustup.sh"
    bash rustup.rs -y
    source "${HOME}/.cargo/env"
fi 
cd ..
if [ ! -d "main" ]; then
    echo "Bad location"
    exit 1
fi 
cd main 
cd cat-rust 
cargo build --release
cd ../modulelaunch
cargo build --release