/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210930 (32-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of C:/Users/user/Documents/GitHub/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh/EFI/OC/ACPI/SSDT-ALL.aml, Tue Nov 11 09:54:22 2025
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000D0D (3341)
 *     Revision         0x02
 *     Checksum         0xDD
 *     OEM ID           "hack"
 *     OEM Table ID     "ALL"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20250807 (539297799)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "ALL", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.AC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.BAT1, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.HKEY, DeviceObj)
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    External (_SB_.PCI0.LPCB.HPET.XCRS, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.HPET.XSTA, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PR00, ProcessorObj)
    External (_SI_._SST, MethodObj)    // 1 Arguments
    External (LNUX, IntObj)
    External (RMCF.BKLT, IntObj)
    External (RMCF.FBTP, IntObj)
    External (RMCF.GRAN, IntObj)
    External (RMCF.LEVW, IntObj)
    External (RMCF.LMAX, IntObj)
    External (STAS, IntObj)
    External (TPDM, IntObj)
    External (WIN8, IntObj)
    External (WNTF, IntObj)

    Scope (\)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                STAS = One
                TPDM = Zero
                LNUX = One
                WNTF = One
                WIN8 = One
            }
        }
    }

    Scope (_SB)
    {
        Device (ALS0)
        {
            Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
            Name (_CID, "smc-als")  // _CID: Compatible ID
            Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
            Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
            {
                Package (0x02)
                {
                    0x64, 
                    0x012C
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x08)
                {
                    "kUSBSleepPowerSupply", 
                    0x13EC, 
                    "kUSBSleepPortCurrentLimit", 
                    0x0834, 
                    "kUSBWakePowerSupply", 
                    0x13EC, 
                    "kUSBWakePortCurrentLimit", 
                    0x0834
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (MCHC)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (PGMM)
        {
            Name (_ADR, 0x00080000)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                If (_OSI ("Darwin"))
                {
                    Return (Package (0x06)
                    {
                        "AAPL,slot-name", 
                        Buffer (0x0F)
                        {
                            "Internal@0,8,0"
                        }, 

                        "device_type", 
                        Buffer (0x12)
                        {
                            "System peripheral"
                        }, 

                        "model", 
                        Buffer (0x58)
                        {
                            "Intel Core Processor Gaussian Mixture Model"
                        }
                    })
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (PMCR)
        {
            Name (_ADR, 0x00120000)  // _ADR: Address
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (SRAM)
        {
            Name (_ADR, 0x00140002)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (XSPI)
        {
            Name (_ADR, 0x001F0005)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x02)
                {
                    "pci-device-hidden", 
                    Buffer (0x08)
                    {
                         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                    }
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Scope (I2C1)
        {
            Scope (TPD0)
            {
                If (_OSI ("Darwin"))
                {
                    Name (OSYS, 0x07DF)
                }
            }
        }

        If (_OSI ("Darwin"))
        {
            Scope (GFX0)
            {
                OperationRegion (RMP3, PCI_Config, Zero, 0x14)
                Device (PNLF)
                {
                    Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                    Name (_CID, "backlight")  // _CID: Compatible ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (_STA, 0x0B)  // _STA: Status
                    Field (^RMP3, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x02), 
                        GDID,   16, 
                        Offset (0x10), 
                        BAR1,   32
                    }

                    OperationRegion (RMB1, SystemMemory, (BAR1 & 0xFFFFFFFFFFFFFFF0), 0x000E1184)
                    Field (RMB1, AnyAcc, Lock, Preserve)
                    {
                        Offset (0x48250), 
                        LEV2,   32, 
                        LEVL,   32, 
                        Offset (0x70040), 
                        P0BL,   32, 
                        Offset (0xC2000), 
                        GRAN,   32, 
                        Offset (0xC8250), 
                        LEVW,   32, 
                        LEVX,   32, 
                        LEVD,   32, 
                        Offset (0xE1180), 
                        PCHL,   32
                    }

                    Method (INI1, 1, NotSerialized)
                    {
                        If ((Zero == (0x02 & Arg0)))
                        {
                            Local5 = 0xC0000000
                            If (CondRefOf (\RMCF.LEVW))
                            {
                                If ((Ones != \RMCF.LEVW))
                                {
                                    Local5 = \RMCF.LEVW /* External reference */
                                }
                            }

                            ^LEVW = Local5
                        }

                        If ((0x04 & Arg0))
                        {
                            If (CondRefOf (\RMCF.GRAN))
                            {
                                ^GRAN = \RMCF.GRAN /* External reference */
                            }
                            Else
                            {
                                ^GRAN = Zero
                            }
                        }
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        Local4 = One
                        If (CondRefOf (\RMCF.BKLT))
                        {
                            Local4 = \RMCF.BKLT /* External reference */
                        }

                        If (!(One & Local4))
                        {
                            Return (Zero)
                        }

                        Local0 = ^GDID /* \_SB_.PCI0.GFX0.PNLF.GDID */
                        Local2 = Ones
                        If (CondRefOf (\RMCF.LMAX))
                        {
                            Local2 = \RMCF.LMAX /* External reference */
                        }

                        Local3 = Zero
                        If (CondRefOf (\RMCF.FBTP))
                        {
                            Local3 = \RMCF.FBTP /* External reference */
                        }

                        If (((One == Local3) || (Ones != Match (Package (0x10)
                                            {
                                                0x010B, 
                                                0x0102, 
                                                0x0106, 
                                                0x1106, 
                                                0x1601, 
                                                0x0116, 
                                                0x0126, 
                                                0x0112, 
                                                0x0122, 
                                                0x0152, 
                                                0x0156, 
                                                0x0162, 
                                                0x0166, 
                                                0x016A, 
                                                0x46, 
                                                0x42
                                            }, MEQ, Local0, MTR, Zero, Zero))))
                        {
                            If ((Ones == Local2))
                            {
                                Local2 = 0x0710
                            }

                            Local1 = (^LEVX >> 0x10)
                            If (!Local1)
                            {
                                Local1 = Local2
                            }

                            If ((!(0x08 & Local4) && (Local2 != Local1)))
                            {
                                Local0 = ((^LEVL * Local2) / Local1)
                                Local3 = (Local2 << 0x10)
                                If ((Local2 > Local1))
                                {
                                    ^LEVX = Local3
                                    ^LEVL = Local0
                                }
                                Else
                                {
                                    ^LEVL = Local0
                                    ^LEVX = Local3
                                }
                            }
                        }
                        ElseIf (((0x03 == Local3) || (Ones != Match (Package (0x19)
                                            {
                                                0x3E9B, 
                                                0x3EA5, 
                                                0x3E92, 
                                                0x3E91, 
                                                0x3EA0, 
                                                0x3EA6, 
                                                0x3E98, 
                                                0x9BC8, 
                                                0x9BC5, 
                                                0x9BC4, 
                                                0xFF05, 
                                                0x8A70, 
                                                0x8A71, 
                                                0x8A51, 
                                                0x8A5C, 
                                                0x8A5D, 
                                                0x8A52, 
                                                0x8A53, 
                                                0x8A56, 
                                                0x8A5A, 
                                                0x8A5B, 
                                                0x9B41, 
                                                0x9B21, 
                                                0x9BCA, 
                                                0x9BA4
                                            }, MEQ, Local0, MTR, Zero, Zero))))
                        {
                            If ((Ones == Local2))
                            {
                                Local2 = 0xFFFF
                            }
                        }
                        Else
                        {
                            If ((Ones == Local2))
                            {
                                If ((Ones != Match (Package (0x16)
                                                {
                                                    0x0D26, 
                                                    0x0A26, 
                                                    0x0D22, 
                                                    0x0412, 
                                                    0x0416, 
                                                    0x0A16, 
                                                    0x0A1E, 
                                                    0x0A1E, 
                                                    0x0A2E, 
                                                    0x041E, 
                                                    0x041A, 
                                                    0x0BD1, 
                                                    0x0BD2, 
                                                    0x0BD3, 
                                                    0x1606, 
                                                    0x160E, 
                                                    0x1616, 
                                                    0x161E, 
                                                    0x1626, 
                                                    0x1622, 
                                                    0x1612, 
                                                    0x162B
                                                }, MEQ, Local0, MTR, Zero, Zero)))
                                {
                                    Local2 = 0x0AD9
                                }
                                Else
                                {
                                    Local2 = 0x056C
                                }
                            }

                            INI1 (Local4)
                            Local1 = (^LEVX >> 0x10)
                            If (!Local1)
                            {
                                Local1 = Local2
                            }

                            If ((!(0x08 & Local4) && (Local2 != Local1)))
                            {
                                Local0 = ((((^LEVX & 0xFFFF) * Local2) / Local1) | 
                                    (Local2 << 0x10))
                                ^LEVX = Local0
                            }
                        }

                        If ((Local2 == 0x0710))
                        {
                            _UID = 0x0E
                        }
                        ElseIf ((Local2 == 0x0AD9))
                        {
                            _UID = 0x0F
                        }
                        ElseIf ((Local2 == 0x056C))
                        {
                            _UID = 0x10
                        }
                        ElseIf ((Local2 == 0x07A1))
                        {
                            _UID = 0x11
                        }
                        ElseIf ((Local2 == 0x1499))
                        {
                            _UID = 0x12
                        }
                        ElseIf ((Local2 == 0xFFFF))
                        {
                            _UID = 0x13
                        }
                        Else
                        {
                            _UID = 0x63
                        }
                    }
                }
            }
        }

        Scope (XHC.RHUB)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }
        }
    }

    Scope (_SB.PCI0.LPCB)
    {
        Device (DMAC)
        {
            Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0000,             // Range Minimum
                    0x0000,             // Range Maximum
                    0x01,               // Alignment
                    0x20,               // Length
                    )
                IO (Decode16,
                    0x0081,             // Range Minimum
                    0x0081,             // Range Maximum
                    0x01,               // Alignment
                    0x11,               // Length
                    )
                IO (Decode16,
                    0x0093,             // Range Minimum
                    0x0093,             // Range Maximum
                    0x01,               // Alignment
                    0x0D,               // Length
                    )
                IO (Decode16,
                    0x00C0,             // Range Minimum
                    0x00C0,             // Range Maximum
                    0x01,               // Alignment
                    0x20,               // Length
                    )
                DMA (Compatibility, NotBusMaster, Transfer8_16, )
                    {4}
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Scope (HPET)
        {
            Name (BUFX, ResourceTemplate ()
            {
                IRQNoFlags ()
                    {0,8,11}
                Memory32Fixed (ReadWrite,
                    0xFED00000,         // Address Base
                    0x00000400,         // Address Length
                    )
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                If ((_OSI ("Darwin") || !CondRefOf (\_SB.PCI0.LPCB.HPET.XCRS)))
                {
                    Return (BUFX) /* \_SB_.PCI0.LPCB.HPET.BUFX */
                }

                Return (\_SB.PCI0.LPCB.HPET.XCRS ())
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((_OSI ("Darwin") || !CondRefOf (\_SB.PCI0.LPCB.HPET.XSTA)))
                {
                    Return (0x0F)
                }

                Return (\_SB.PCI0.LPCB.HPET.XSTA ())
            }
        }

        Scope (EC)
        {
            If (_OSI ("Darwin"))
            {
                OperationRegion (ESEN, EmbeddedControl, Zero, 0x0100)
                Field (ESEN, ByteAcc, Lock, Preserve)
                {
                    Offset (0x78), 
                    EST0,   8, 
                    EST1,   8, 
                    EST2,   8, 
                    EST3,   8, 
                    EST4,   8, 
                    EST5,   8, 
                    EST6,   8, 
                    EST7,   8, 
                    Offset (0xC0), 
                    EST8,   8, 
                    EST9,   8, 
                    ESTA,   8, 
                    ESTB,   8, 
                    ESTC,   8, 
                    ESTD,   8, 
                    ESTE,   8, 
                    ESTF,   8
                }
            }

            Method (RE1B, 1, NotSerialized)
            {
                OperationRegion (ERAM, EmbeddedControl, Arg0, One)
                Field (ERAM, ByteAcc, NoLock, Preserve)
                {
                    BYTE,   8
                }

                Return (BYTE) /* \_SB_.PCI0.LPCB.EC__.RE1B.BYTE */
            }

            Method (RECB, 2, Serialized)
            {
                Arg1 = ((Arg1 + 0x07) >> 0x03)
                Name (TEMP, Buffer (Arg1){})
                Arg1 += Arg0
                Local0 = Zero
                While ((Arg0 < Arg1))
                {
                    TEMP [Local0] = RE1B (Arg0)
                    Arg0++
                    Local0++
                }

                Return (TEMP) /* \_SB_.PCI0.LPCB.EC__.RECB.TEMP */
            }

            Method (WE1B, 2, NotSerialized)
            {
                OperationRegion (ERAM, EmbeddedControl, Arg0, One)
                Field (ERAM, ByteAcc, NoLock, Preserve)
                {
                    BYTE,   8
                }

                BYTE = Arg1
            }

            Method (WECB, 3, Serialized)
            {
                Arg1 = ((Arg1 + 0x07) >> 0x03)
                Name (TEMP, Buffer (Arg1){})
                TEMP = Arg2
                Arg1 += Arg0
                Local0 = Zero
                While ((Arg0 < Arg1))
                {
                    WE1B (Arg0, DerefOf (TEMP [Local0]))
                    Arg0++
                    Local0++
                }
            }

            Method (NBAT, 0, Serialized)
            {
                If (CondRefOf (BAT1))
                {
                    Notify (BAT1, 0x80) // Status Change
                }
            }

            Scope (AC)
            {
                If (_OSI ("Darwin"))
                {
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x17, 
                        0x03
                    })
                }
            }

            Scope (HKEY)
            {
                If (_OSI ("Darwin"))
                {
                    Name (OSYS, 0x07DF)
                }

                Method (CSSI, 1, NotSerialized)
                {
                    If (_OSI ("Darwin"))
                    {
                        \_SI._SST (Arg0)
                    }
                }
            }
        }
    }

    Scope (_SB.PCI0.SBUS)
    {
        Device (BUS0)
        {
            Name (_CID, "smbus")  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Device (DVL0)
            {
                Name (_ADR, 0x57)  // _ADR: Address
                Name (_CID, "diagsvault")  // _CID: Compatible ID
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x02)
                    {
                        "address", 
                        0x57
                    })
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }

    Method (PMPM, 4, NotSerialized)
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
                 0x03                                             // .
            })
        }

        Return (Package (0x02)
        {
            "plugin-type", 
            One
        })
    }

    If (CondRefOf (\_SB.PR00))
    {
        If ((ObjectType (\_SB.PR00) == 0x0C))
        {
            Scope (\_SB.PR00)
            {
                If (_OSI ("Darwin"))
                {
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Return (PMPM (Arg0, Arg1, Arg2, Arg3))
                    }
                }
            }
        }
    }
}

