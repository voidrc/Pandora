# Pandora

> When nothing goes right....  Go left

Pandora is a toolkit that provides a comprehensive solution for restoring and configuring an Arch-based cybersecurity workspace. The restoration process is orchestrated by the main `Pandora` script, which coordinates several specialized scripts to recreate complete Hyprland working environment.

## Usage
```bash
git clone https://github.com/voidrc/Pandora.git 
./restore.sh
```

## Troubleshooting
**Common Issues**:
- **Missing Dependencies**: Ensure `yay` is installed before running `packages`
- **Permission Errors**: Run scripts as regular user (not root) with sudo access
- **Backup Not Found**: Place backups in `./BackUps` relative to `configs`

## License
MIT License - Free for personal and professional use  
**Disclaimer**: Use at your own risk. Always test in non-critical environments first.