# PoShLog.Sinks.MSSqlServer

[![psgallery](https://img.shields.io/powershellgallery/v/poshlog.sinks.MSSqlServer.svg)](https://www.powershellgallery.com/packages/PoShLog.Sinks.MSSqlServer) [![PowerShell Gallery](htps://imgshields.io/powershellgallery/p/poshlog.sinks.MSSqlServer?color=blue)](https://www.powershellgallery.com/packages/PoShLog.Sinks.MSSqlServer) [![psgallery](https://img.shields.io/powershllgallerydt/PoShLog.Sinks.MSSqlServer.svg)](https://www.powershellgallery.com/packages/PoShLog.Sinks.MSSqlServer) [![Discord](https://img.shields.io/discord/693754316305072199?color=orange&label=discord)](https://discord.gg/FVdVxuw)

PoShLog.Sinks.MSSqlServer is extension module for [PoShLog](https://github.com/PoShLog/PoShLog) logging module. Contains sink that writes log messages into MSSQL server databse.

## Getting started

If you are familiar with PowerShell, skip to [Installation](#installation) section. For more detailed installation instructions check out [Getting started](https://github.com/PoShLog/PoShLog/wiki/Getting-started) wiki.

### Installation

To install PoShLog.Sinks.MSSqlServer, run following snippet from owershell

```ps1
Install-Module -Name PoShLog.Sinks.MSSqlServer
```

## Usage

```ps1
Import-Module PoShLog
Import-Module PoShLog.Sinks.MSSqlServer

New-Logger | 
    Add-SinkMSSqlServer -ConnectionString 'Server=.;Database=dummy;Integrated Security=SSPI;' | 
    Start-Logger

# Your code here

# Don't forget to close the logger
Close-Logger
```

### Documentation

These examples are just to get you started fast. For more detailed documentation please check [wiki](https://github.com/PoShLog/PoShLog/wiki).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Authors

Tomáš Bouda

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

* `Serilog.Sinks.MSSqlServer` - [serilog/serilog-sinks-mssqlserver](https://github.com/serilog/serilog-sinks-mssqlserver)
* Icon made by [Smashicons](https://smashicons.com/) from [www.flaticon.com](https://www.flaticon.com/).
