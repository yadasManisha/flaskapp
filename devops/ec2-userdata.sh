#!/bin/bash -xeu
sudo apt update -y
sudo apt-get install python3-venv -y
mkdir myapp
cd myapp
python3 -m venv demo
source demo/bin/activate
pip install flask gunicorn
sudo git clone https://github.com/yadasManisha/flaskapp.git 
cat <<EOF > /etc/systemd/system/myapp.service
Description=Gunicorn instance for a simple hello world app
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/myapp/flaskapp
ExecStart=/home/ubuntu/myapp/demo/bin/gunicorn -b localhost:8000 app:app
Restart=always
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start myapp
sudo systemctl enable myapp
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx 

sudo cp /home/ubuntu/myapp/flaskapp/devops/defualt /etc/nginx/sites-available/default
sudo systemctl restart nginx
