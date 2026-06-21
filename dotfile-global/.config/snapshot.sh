#!/usr/bin/env bash

# ==============================================================================
# SCRIPT: arch-snapshot.sh
# DESCRIPTION: Automated system snapshot creation via Timeshift and GRUB reload
# ==============================================================================

# Ensure the script is run with root privileges from the start
if [ "$EUID" -ne 0 ]; then
    echo "❌ ERROR: This script must be run as root (sudo)."
    exit 1
fi

echo "=================================================="
echo "📸 Initiating Timeshift snapshot creation..."
echo "=================================================="

BACKUP_COMMENT="Manual backup ($(date '+%Y-%m-%d %H:%M:%S'))"

# Run timeshift directly since we already checked for root execution
if timeshift --create --comments "$BACKUP_COMMENT"; then
    echo ""
    echo "=================================================="
    echo "✅ SUCCESS: Snapshot has been saved securely!"
    echo "🔄 Regenerating GRUB configuration file..."
    echo "=================================================="
    
    # Executing grub-mkconfig safely with full root path integrity
    if grub-mkconfig -o /boot/grub/grub.cfg; then
        echo ""
        echo "=================================================="
        echo "🎉 DONE: Snapshot created and GRUB updated successfully!"
        echo "=================================================="
        exit 0
    else
        echo ""
        echo "=================================================="
        echo "⚠️  WARNING: Backup succeeded, but GRUB update failed."
        echo "👉 Please check your /boot partition or GRUB logs manually."
        echo "=================================================="
        exit 3
    fi
else
    echo ""
    echo "=================================================="
    echo "❌ ERROR: Timeshift snapshot creation failed!"
    echo "⚠️  GRUB generation aborted for system safety."
    echo "👉 Check your disk space or Timeshift configurations."
    echo "=================================================="
    exit 2
fi
