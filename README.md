# CTBeats Nginx Configuration Backup

This repository contains the nginx configuration files from the CTBeats production server.

## Structure

- `nginx.conf` - Main nginx configuration
- `sites-available/` - Virtual host configurations
  - `901FM` - FM website (fm.ctbeatsmedia.com, ctbeatsmedia.com)
  - `api.conf` - Public API (api.ctbeatsmedia.com)
  - `cms.conf` - CMS (cms.ctbeatsmedia.com)
  - `file-server.conf` - File server (files.ctbeatsmedia.com)
  - `hls-stream.conf` - HLS streaming (stream-hls.ctbeatsmedia.com)
  - `icecast.conf` - Icecast streaming (stream.ctbeatsmedia.com, icecast2_internal.ctbeatsmedia.com)
- `conf.d/default.conf` - Default server config
- `ssl/` - SSL certificates (not included for security - regenerate as needed)

## Backup Date

Generated on: 2026-11-23 08:07:13 UTC

## Permissions

Git does not preserve Unix file permissions, ownership, or SELinux contexts. On restore, run the included `restore.sh` script which sets ownership (`root:root`) and mode (`644` for configs, `755` for directories) and re-creates the `sites-enabled` symlinks.

## Restore

On the CTBeats server (`ctbeats@103.254.63.56`):

```bash
# Clone this repo
git clone https://github.com/CTBeats/nginx-config.git
cd nginx-config

# Run the restore script
sudo ./restore.sh

# Test and reload nginx
sudo nginx -t && sudo systemctl reload nginx
```

Or restore manually:

```bash
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp sites-available/* /etc/nginx/sites-available/
sudo cp conf.d/default.conf /etc/nginx/conf.d/
sudo chown root:root /etc/nginx/nginx.conf /etc/nginx/sites-available/* /etc/nginx/conf.d/default.conf
sudo chmod 644 /etc/nginx/nginx.conf /etc/nginx/sites-available/* /etc/nginx/conf.d/default.conf
sudo chmod 755 /etc/nginx/sites-available
sudo nginx -t && sudo systemctl reload nginx
```

Note: SSL certificates must be provisioned separately (Let's Encrypt or existing certs).

## Release Archive

A compressed tar.gz of the nginx configuration (with preserved permissions) is attached to the [2026-11-23 release](https://github.com/CTBeats/nginx-config/releases/tag/2026-11-23).

```bash
curl -L https://github.com/CTBeats/nginx-config/releases/download/2026-11-23/nginx-config-2026-11-23.tar.gz -o nginx-config.tar.gz
tar xzf nginx-config.tar.gz
sudo ./restore.sh
```
