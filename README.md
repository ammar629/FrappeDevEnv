# FrappeDevEnv
This script automatically setup development env on a clean ubuntu server.

# Steps
* Enter These Commands
```
sudo apt install git
git clone https://github.com/ammar629/FrappeDevEnv
cd FrappeDevEnv
chmod +x install_erpnext.sh
sudo ./install_erpnext.sh
```

* If prompted for any passwords just type your preferred password but make sure to remember them
* Switch To Unix Socket Authentication -> N
* Change Root Password -> Y
* Remove Anonymous Users -> Y
* Disallow Root Login Remotely -> N
* Remove test database and access to it-> Y
* Reload privileges tables now -> Y
