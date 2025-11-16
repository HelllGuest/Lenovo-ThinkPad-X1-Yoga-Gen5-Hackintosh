# 🧭 Changelog – Lenovo ThinkPad X1 Yoga Gen 5 Hackintosh

All notable changes to this Hackintosh EFI are documented here in semantic format.

---

## [1.0.6] – 2025-11-11
**macOS Ventura 13.7.8 – OpenCore 1.0.6**

```yaml
Changes:
  - Updated OpenCore to 1.0.6 (ACDT 2025-10)
  - Improved CPU power management for i7-10610U
  - Rebuilt USB mapping using USBToolBox (v3 schema)
  - Optimized SSDT-YOGA for YogaSMC sensor handling
  - Reworked ACPI hotpatch for _PTS/_WAK consistency
  - Improved fan control profiles in YogaSMC
  - Verified FileVault boot with full graphics acceleration
Fixes:
  - Corrected ALC285 layout ID mismatch
  - Fixed wake issue on lid open
  - Resolved NVRAM persistence under OC Quirks
Removed:
  - Legacy VoodooInput.kext
Notes:
  - Tested on BIOS 1.40
  - CFG Lock cannot be disabled (AppleXcpmCfgLock quirk enabled)
  - Recommended SMBIOS: MacBookPro16,3
  - Sleep mode must be set to "Linux" in BIOS
  - Based on AlexFullmoon's original project
```

---

## [1.0.5] – 2025-09-07

**macOS Ventura 13.6 – OpenCore 1.0.5**

```yaml
Changes:
  - Initial stable EFI release
  - Full support for Intel AX201 WiFi/BT
  - Optimized SSDT-EC, SSDT-PLUG, SSDT-USBX mappings
  - Implemented YogaSMC and VirtualSMC sensor suite
  - Verified sleep/wake, FileVault, and iServices
```

---

## [Unreleased]

### Documentation Updates – 2025-11-16

```yaml
Added:
  - recovery_config.plist for macOS installation and troubleshooting
  - Comprehensive documentation comparing config.plist vs recovery_config.plist
  - Installation guide section for switching between configs
  - Boot issues & recovery mode section in troubleshooting guide
  - Navigation structure to mkdocs.yml for local documentation building
  
Changed:
  - Updated README.md with EFI directory structure including recovery_config.plist
  - Enhanced config_reference.md with detailed config variants comparison table
  - Improved installation guide with step-by-step config switching instructions
  - Completed mkdocs.yml with proper site metadata and navigation
  
Removed:
  - GitHub Actions workflow for automated documentation deployment
  - .github/workflows/mkdocs-deploy.yml (users can still build docs locally)

Notes:
  - config.plist: Production config with hibernation, optimized graphics, SIP enabled
  - recovery_config.plist: Installation config with verbose boot, debug logging, relaxed security
  - Key difference: AAPL,ig-platform-id (0x3e9b0000 vs 0x3e9b0009)
  - Users should use recovery_config.plist during installation, then switch to config.plist
```

---

```yaml
Planned:
  - macOS Sequoia support validation
  - Refined Thunderbolt 3 hotplug (SSDT-TB3)
  - AppleALC 1.9.x integration test
```