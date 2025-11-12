# 🖥️ Hardware Compatibility – X1 Yoga Gen 5

## ✅ Confirmed Working

| Component | Notes | Implementation |
|------------|--------|----------------|
| Wi-Fi (Intel AX201) | Wi-Fi 6 speeds | AirportItlwm.kext |
| Bluetooth 5.1 | Full LE support | IntelBluetoothFirmware + IntelBTPatcher + BlueToolFixup |
| Audio (ALC285) | All outputs working | AppleALC.kext (Layout ID 71 via DeviceProperties) |
| Trackpad (I2C) | Multi-touch gestures | VoodooI2C + VoodooI2CHID |
| TrackPoint | Full support | VoodooRMI + RMII2C |
| Keyboard | All keys working | VoodooPS2Controller |
| Battery | Accurate readings | SMCBatteryManager + EC patches in SSDT-ALL |
| Brightness | Smooth control | PNLF in SSDT-ALL + BrightnessKeys.kext |
| Ambient Light | Auto brightness | ALS0 in SSDT-ALL + SMCLightSensor |
| USB Ports | All functional | USBToolBox + USBMap.kext (RHUB disabled) |
| Ethernet | Via adapter | IntelMausi.kext |
| NVMe SSD | Optimized | NVMeFix.kext |
| CPU Power | Native PM | PLUG _DSM in SSDT-ALL |
| Sleep/Wake | Stable | HibernationFixup + RTCMemoryFixup |
| ThinkPad Features | Fan, sensors, HKEY | YogaSMC.kext + EC HKEY in SSDT-ALL |

---

## ⚠️ Partial or Unsupported

| Component | Notes |
|------------|--------|
| Touchscreen | Basic touch only (no gestures) |
| Fingerprint Reader | Unsupported in macOS |
| Thunderbolt 3 | Controller visible, DP works, advanced features untested |
| eGPU | Untested (requires SSDT-TB.aml) |
| TB3 Hotplug | Limited (requires SSDT-TB.aml) |


---

## 🔧 BIOS Configuration

### Critical Settings (Required)

| Setting | Location | Value | Reason |
|---------|----------|-------|--------|
| Sleep mode | Power | **Linux** | Required for proper sleep/wake |
| Secure Boot | Security | **Disabled** | macOS incompatible |
| Vt-d | Virtualization | **Disabled** | Or use DisableIOMapper quirk |
| Enhanced Windows Biometrics | Virtualization | **Disabled** | macOS incompatible |
| Intel SGX | IO Ports | **Disabled** | Security feature conflicts |
| Device Guard | IO Ports | **Disabled** | Windows security feature |
| UEFI/Legacy | Startup | **UEFI** | Legacy not supported |
| CSM Support | Startup | **Disabled** | UEFI-only mode |

### Recommended Settings

| Setting | Location | Value | Reason |
|---------|----------|-------|--------|
| Wake-on-LAN | Config → Network | Disabled | Prevents unwanted wake |
| UEFI network stack | Config → Network | Disabled | Not needed |
| Thunderbolt BIOS Assist | Thunderbolt | Disabled | Better compatibility |
| Thunderbolt Security | Thunderbolt | Disabled | Simplifies setup |
| Thunderbolt Preboot | Thunderbolt | Disabled | Not needed |
| Intel AMT | Thunderbolt | Disabled | Not used |
| Fingerprint predesktop | Security | Disabled | Not supported in macOS |
| Kernel DMA | Virtualization | Disabled | Better compatibility |
| WWAN | IO Ports | Disabled | If not using cellular |
| Fingerprint | IO Ports | Disabled | If macOS-only |

### ⚠️ CFG Lock Status

**Important:** CFG Lock **cannot be disabled** on X1 Yoga Gen 5 through standard BIOS menu.

- Located in hidden engineering menu
- Standard unlock methods (modified GRUB, RU.efi) **do not work**
- Direct BIOS write with programmer clip possible but **dangerous**:
  - Requires hardware programmer and clip
  - Risk of bricking motherboard
  - **Breaks TPM** functionality
  - Voids warranty

**Solution:** This EFI uses `AppleXcpmCfgLock = True` kernel quirk to work around locked CFG. No BIOS modification needed.

### BIOS Version

- **Current tested:** 1.40
- **Previously tested:** 1.31+
- **Recommended:** Keep BIOS updated to latest stable version
- **Download:** [Lenovo Support Site](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x1-yoga-gen-5-type-20ub-20uc/downloads/driver-list/)
- **Note:** BIOS updates may reset settings - verify all settings after update

---

## ⚡ Thunderbolt 3 Support

### Current Status

**Working:**
- Thunderbolt 3 controller visible in System Information
- External displays via USB-C/Thunderbolt ports (DisplayPort mode)
- USB-C data transfer
- Hotplug external monitors

**Untested/Limited:**
- eGPU (external graphics card)
- Thunderbolt 3 storage devices
- Thunderbolt 3 docks with advanced features
- Daisy-chaining multiple TB3 devices

### Hardware Details

- **Controller:** Intel JHL6540 Alpine Ridge Thunderbolt 3 (Low Power)
- **Device ID:** `8086:15D2` (Intel Corporation)
- **Subsystem ID:** `22BE:17AA` (Lenovo ThinkPad X1 Yoga Gen 5)
- **Ports:** 2x USB-C with Thunderbolt 3 support
- **Location:** PCI Root Port 13 (RP13) at `0x001D0004`

### Optional SSDT-TB Patch

An optional `SSDT-TB.aml` file is **included but disabled by default**:

**What it does:**
- Creates full Thunderbolt 3 device tree for RP13
- Adds UPSB (Upstream Bridge) and DSB0-6 (Downstream Bridge) devices
- Implements NHI0 (Native Host Interface) controller
- Configures XHC2 (USB 3.1 controller) for TB3 ports with 2 USB-C ports
- Adds ThunderboltDROM and ThunderboltConfig properties
- Enables proper device removal status (_RMV) for hotplug
- Implements DTGP method for device properties

**Device Tree:**
```
RP13 (Root Port 13)
└── UPSB (Upstream Bridge)
    ├── DSB0 (Downstream Bridge 0)
    │   └── NHI0 (Thunderbolt Controller)
    ├── DSB1 (Downstream Bridge 1) - Hotplug capable
    ├── DSB2 (Downstream Bridge 2)
    │   └── XHC2 (USB 3.1 Controller)
    │       └── RHUB (Root Hub)
    │           ├── SSP1 (USB-C Port 1)
    │           └── SSP2 (USB-C Port 2)
    └── DSB4 (Downstream Bridge 4) - Hotplug capable
```

**To enable:**
1. Open `config.plist` with ProperTree or text editor
2. Navigate to `ACPI → Add`
3. Add new entry:
```xml
<dict>
    <key>Comment</key>
    <string>Thunderbolt 3 Alpine Ridge Support</string>
    <key>Enabled</key>
    <true/>
    <key>Path</key>
    <string>SSDT-TB.aml</string>
</dict>
```
4. Save and reboot

**Current Status:**
- ✅ File compiled and present in `EFI/OC/ACPI/SSDT-TB.aml`
- ❌ Not enabled in config.plist (disabled by default)
- ⚠️ Requires testing with actual TB3 devices (eGPU, TB3 storage, TB3 docks)
- ✅ DisplayPort output works without this patch

**Note:** This patch is experimental. Basic DisplayPort functionality works without it. Enable only if you need advanced Thunderbolt features or have issues with TB3 devices.

**Extracting Hardware-Specific DROM Data:**

The current SSDT-TB uses generic ThunderboltDROM data. For advanced features (eGPU, advanced hotplug), you may need hardware-specific DROM data. Methods to extract:

**Method 1: Windows (Recommended)**

**Using Intel Thunderbolt Software:**
1. Boot into Windows on the same machine
2. Download and install [Intel Thunderbolt Software](https://www.intel.com/content/www/us/en/download-center/home.html)
3. Open Device Manager → System Devices → Thunderbolt Controller
4. Right-click → Properties → Details → Hardware IDs
5. Verify the IDs match:
   - **Device ID:** `PCI\VEN_8086&DEV_15D2` (Intel JHL6540)
   - **Subsystem ID:** `SUBSYS_17AA22BE` (Lenovo ThinkPad X1 Yoga Gen 5)

**Using PowerShell/Registry:**
```powershell
# Find Thunderbolt controller
Get-PnpDevice | Where-Object {$_.FriendlyName -like "*Thunderbolt*"}

# Check registry for DROM data
reg query "HKLM\SYSTEM\CurrentControlSet\Enum\PCI" /s /f "Thunderbolt"
```

**Using Third-Party Tools:**
- [Thunderbolt DROM Reader](https://github.com/RehabMan/Thunderbolt-DROM-Reader) (if available)
- Use `RWEverything` or `PCITree` to read PCI configuration space
- DROM is typically stored in PCI config space or NVRAM

**Method 2: Linux (Most Reliable)**

```bash
# Install thunderbolt-tools
sudo apt install thunderbolt-tools  # Debian/Ubuntu
sudo dnf install thunderbolt-tools  # Fedora/RHEL
sudo pacman -S thunderbolt-tools    # Arch

# List Thunderbolt controllers
sudo boltctl list

# Read DROM from controller (usually /dev/thunderbolt0)
sudo cat /sys/bus/thunderbolt/devices/0-0/drom > drom.bin

# Alternative: Use thunderbolt-tools
sudo thunderbolt read-drom > drom.bin

# Verify DROM size (should be 117 bytes / 0x75 for Alpine Ridge)
ls -lh drom.bin

# Convert binary to hex format for ACPI
xxd -i drom.bin > drom.h
# Or with comments:
xxd -g 1 drom.bin | awk '{printf "/* %04X */  ", NR-1; for(i=2;i<=9;i++) printf "0x%s, ", $i; print ""}'
```

**Method 3: macOS (if Thunderbolt already working)**

**Using IORegistryExplorer:**
1. Download [IORegistryExplorer](https://developer.apple.com/download/all/) (requires Apple Developer account)
2. Open IORegistryExplorer
3. Navigate to: `IOThunderboltFamily` → `IOThunderboltController`
4. Find `ThunderboltDROM` property
5. Right-click → Copy as Property List or Export

**Using Terminal:**
```bash
# Find Thunderbolt controller
ioreg -l | grep -A 20 "IOThunderboltController"

# Extract DROM (if accessible)
ioreg -l -w 0 | grep "ThunderboltDROM" | head -1

# Use Python script to parse IOReg output
python3 << EOF
import plistlib
import sys
# Parse IOReg output and extract DROM hex data
EOF
```

**Method 4: Direct PCI Access (Advanced)**

**Using setpci (Linux):**
```bash
# Find Thunderbolt controller
lspci | grep -i thunderbolt
# Output: XX:XX.X Thunderbolt controller: Intel Corporation JHL6540 Thunderbolt 3 Controller

# Verify device and subsystem IDs
lspci -nn | grep -i thunderbolt
# Should show: XX:XX.X Thunderbolt controller [8086:15D2] (rev XX) (subsys [22BE:17AA])

# Read PCI config space (DROM may be in extended config)
sudo setpci -s XX:XX.X BASE_ADDRESS_0

# Use mmap to read DROM from PCI memory space
# (Requires custom tool or kernel module)
```

**Method 5: BIOS/UEFI Firmware**

Some BIOS/UEFI firmware contains DROM data:
- Use `UEFITool` or `IFR Extractor` to examine firmware
- Look for Thunderbolt-related ACPI tables
- Extract from DSDT/SSDT tables if present
- Requires advanced reverse engineering knowledge

**Converting Extracted DROM to ACPI Format:**

After extracting `drom.bin` (should be 117 bytes / 0x75 hex):

```bash
# Method 1: Using xxd (Linux/macOS)
xxd -i drom.bin | sed 's/unsigned char/\/\* 0000 \*\/  /' | \
  sed 's/\[/Buffer (0x75)\n                                        {/' | \
  sed 's/\]/}/' | sed 's/,/,\n                                            /g'

# Method 2: Python script
python3 << 'EOF'
with open('drom.bin', 'rb') as f:
    data = f.read()
    print('Buffer (0x%02X)' % len(data))
    print('{')
    for i in range(0, len(data), 8):
        hex_bytes = ', '.join(['0x%02X' % b for b in data[i:i+8]])
        print('    /* %04X */  %s%s' % (i, hex_bytes, ',' if i+8 < len(data) else ''))
    print('}')
EOF
```

**Replacing DROM in SSDT-TB.dsl:**

1. Open `EFI/OC/ACPI/SSDT-TB.dsl`
2. Find the `ThunderboltDROM` buffer (around line 263-280)
3. Replace the hex values with your extracted DROM data
4. Ensure buffer size matches (0x75 = 117 bytes)
5. Recompile: `iasl -ve SSDT-TB.dsl`
6. Test with actual Thunderbolt devices

**Verification:**

**Before Extraction:**
- Verify controller IDs match:
  - Device ID: `8086:15D2` (Intel JHL6540)
  - Subsystem ID: `22BE:17AA` (Lenovo ThinkPad X1 Yoga Gen 5)
- This ensures you're extracting DROM from the correct hardware

**After Replacing DROM:**
- DROM size is correct (117 bytes / 0x75 for Alpine Ridge)
- First byte should be 0x13 (DROM header version)
- Contains valid vendor/device information matching your hardware
- SSDT compiles without errors (`iasl -ve SSDT-TB.dsl`)
- Test with actual Thunderbolt devices to verify functionality

### Thunderbolt BIOS Settings

For best Thunderbolt compatibility:
- Thunderbolt BIOS Assist mode → Disabled
- Thunderbolt Security → Disabled (or set to "No Security")
- Thunderbolt Preboot → Disabled
- Intel VT-d → Disabled (or use DisableIOMapper quirk)
