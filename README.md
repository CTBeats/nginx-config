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

Generated on: $(date -u +"%Y-%m-%d %H:%M:%S UTC")

## Restore

```bash
# Copy configs to server
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp sites-available/* /etc/nginx/sites-available/
sudo cp conf.d/default.conf /etc/nginx/conf.d/
# Re-create symlinks in sites-enabled as needed
sudo nginx -t && sudo systemctl reload nginx
```

Note: SSL certificates must be provisioned separately (Let's Encrypt or existing certs).