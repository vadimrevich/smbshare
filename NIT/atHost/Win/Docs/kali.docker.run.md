# Pull Docker Container

```
sudo docker pull kalilinux/kali-rolling:arm64
```

# Run Docker Container

### Test Run (Remove after close)

```bash
sudo docker run --rm --name kali-container -it kalilinux/kali-rolling:arm64 /bin/bash
```

### Run at Background

```bash
sudo docker run -d --name kali-container -it kalilinux/kali-rolling:arm64 /bin/bash
```

# Commit Container to Image

```bash
sudo docker commit kali-container yudenisov/kali-rolling-image-000:arm64
```

# Copy to Kali Container (Test)

```bash
sudo docker cp /home/vagrant/Hidden/gitverse/system-kali-aarch64 kali-container:/root/
```

### Copy sources.list inside Kali Container

```bash
cp -v /root/system-kali-aarch64/etc/apt/sources.list-kali0 /etc/apt/sources.list
```

### Mask Dialog Error Message

```bash
apt update
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
apt-get install -y -q
apt-get install -y dialog apt-utils
```

### Install editors and File Managers

```bash
apt install -y vim nano mc less sudo apt-transport-https locales apt-file libcom-err2
```
### Change default Kali Linux Repository
##### Attention!!! Please change https: to http: if not working

```bash
sudo nano /etc/apt/sources.list
```

### System update and Upgrade

```bash
sudo apt update && sudo apt dist-upgrade -y
```
### Install Systemd

```bash
apt install -y systemd systemd-sysv
```

## Run a kali docker container with SystemD as background

```bash
docker run -d --rm \
--tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
--name kali-container \
-it \
yudenisov/kali-rolling-image-000:arm64 \
/bin/bash
```